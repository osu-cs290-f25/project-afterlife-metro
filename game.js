(() => {
  const overlay = document.getElementById('fade-overlay');
  const timerDisplay = document.getElementById('timer-display');
  const pauseBtn = document.getElementById('pause-btn');
  const endBtn = document.getElementById('end-game-btn');

  // Initialize modules
  PauseMenu.init();
  EndGameModal.init();

  // Setup callbacks
  PauseMenu.setOnResume(() => {
    Timer.resume((ms) => {
      timerDisplay.textContent = Timer.formatTime(ms);
    });
  });

  PauseMenu.setOnQuit(() => {
    window.location.href = 'homescreen.html';
  });

  EndGameModal.setOnCancel(() => {
    Timer.resume((ms) => {
      timerDisplay.textContent = Timer.formatTime(ms);
    });
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
      window.location.href = 'homescreen.html';
    } catch (err) {
      alert('Could not save score. Please try again.');
      console.error(err);
    }
  };

  // Handle fade overlay end -> enable play and start timer
  overlay.addEventListener('animationend', () => {
    overlay.remove();
    Timer.start((ms) => {
      timerDisplay.textContent = Timer.formatTime(ms);
    });
  });

  // Button event listeners
  pauseBtn.addEventListener('click', () => {
    if (!PauseMenu.isPausedState()) {
      Timer.pause();
      PauseMenu.open();
    }
  });

  endBtn.addEventListener('click', () => {
    const finalMs = Timer.pause();
    EndGameModal.open(finalMs);
  });

  // Safety: prevent overlay from blocking if animation doesn't fire
  window.addEventListener('load', () => {
    setTimeout(() => {
      if (overlay.isConnected) {
        overlay.remove();
        Timer.start((ms) => {
          timerDisplay.textContent = Timer.formatTime(ms);
        });
      }
    }, 3500);
  });
})();
