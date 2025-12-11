(() => {
  const saveScoreBtn = document.getElementById('save-score-btn');
  let finalGameTime = 0;

  // Initialize the end game modal
  EndGameModal.init();

  // Get the game time from URL parameters or session storage
  const params = new URLSearchParams(window.location.search);
  const timeParam = params.get('time');
  
  if (timeParam) {
    finalGameTime = parseInt(timeParam);
  } else if (sessionStorage.getItem('gameTime')) {
    finalGameTime = parseInt(sessionStorage.getItem('gameTime'));
  }

  // Setup save score button
  saveScoreBtn.addEventListener('click', () => {
    EndGameModal.open(finalGameTime);
  });

  // Setup modal callbacks
  EndGameModal.setOnCancel(() => {
    // Just close the modal, stay on thank you screen
  });

  EndGameModal.setOnSubmit((team, timeMs) => {
    submitScore(team, timeMs);
  });

  const submitScore = async (team, timeMs) => {
    const payload = { team, timeMs, createdAt: new Date().toISOString() };
    try {
      const res = await fetch('/api/scores', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      if (!res.ok) throw new Error('Failed to save score');
      alert('Score saved successfully!');
      EndGameModal.close();
      window.location.href = 'homescreen.html';
    } catch (err) {
      alert('Could not save score. Please try again.');
      console.error(err);
    }
  };
})();
