(() => {
  const overlay = document.getElementById('fade-overlay');
  const timerDisplay = document.getElementById('timer-display');
  const pauseBtn = document.getElementById('pause-btn');

  // Initialize modules
  PauseMenu.init();

  // Setup callbacks
  PauseMenu.setOnResume(() => {
    Timer.resume((ms) => {
      timerDisplay.textContent = Timer.formatTime(ms);
    });
  });

  PauseMenu.setOnQuit(() => {
    window.location.href = 'homescreen.html';
  });

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

  // Listen for game completion signal from Godot
  window.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'gameCompleted') {
      const finalTime = Timer.pause();
      sessionStorage.setItem('gameTime', finalTime);
      (async () => {
        const origin = window.location.origin || (window.location.protocol + '//' + window.location.host);
        const candidates = [origin + '/thankyou.html', origin + '/Afterlife-Metro/thankyou.html'];
        for (const url of candidates) {
          try {
            const res = await fetch(url, { method: 'HEAD' });
            if (res.ok) { window.location.href = url; return; }
          } catch (e) {}
        }
        // fallback
        window.location.href = candidates[0];
      })();
    }
  });

  // Alternative: Listen for postMessage from iframe
  const gameFrame = document.getElementById('game-frame');
  if (gameFrame) {
    gameFrame.addEventListener('load', () => {
      // Expose function that Godot can call via window.parent
      window.completeGame = () => {
        const finalTime = Timer.pause();
        sessionStorage.setItem('gameTime', finalTime);
        (async () => {
          const origin = window.location.origin || (window.location.protocol + '//' + window.location.host);
          const candidates = [origin + '/thankyou.html', origin + '/Afterlife-Metro/thankyou.html'];
          for (const url of candidates) {
            try {
              const res = await fetch(url, { method: 'HEAD' });
              if (res.ok) { window.location.href = url; return; }
            } catch (e) {}
          }
          window.location.href = candidates[0];
        })();
      };
    });
  }
})();
