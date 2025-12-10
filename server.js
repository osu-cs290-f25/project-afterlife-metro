const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;
const DATA_FILE = path.join(__dirname, 'scores.json');

app.use(express.json({ limit: '1mb' }));
app.use(express.static(path.join(__dirname)));

const readScores = async () => {
  try {
    const raw = await fs.promises.readFile(DATA_FILE, 'utf8');
    return JSON.parse(raw);
  } catch (err) {
    if (err.code === 'ENOENT') return [];
    throw err;
  }
};

const writeScores = async (scores) => {
  const safe = Array.isArray(scores) ? scores : [];
  await fs.promises.writeFile(DATA_FILE, JSON.stringify(safe, null, 2));
};

app.get('/api/scores', async (req, res) => {
  try {
    const scores = await readScores();
    const sorted = scores
      .filter((s) => typeof s?.timeMs === 'number' && Number.isFinite(s.timeMs))
      .sort((a, b) => a.timeMs - b.timeMs);
    res.json(sorted);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load scores' });
  }
});

app.post('/api/scores', async (req, res) => {
  try {
    const { team, timeMs, createdAt } = req.body || {};
    const name = (team || '').toString().trim();
    const time = Number(timeMs);

    if (!name) return res.status(400).json({ error: 'Team name required' });
    if (!Number.isFinite(time) || time < 0) return res.status(400).json({ error: 'Invalid timeMs' });

    const entry = {
      team: name.slice(0, 80),
      timeMs: time,
      createdAt: createdAt || new Date().toISOString(),
    };

    const scores = await readScores();
    scores.push(entry);
    await writeScores(scores);

    res.json({ ok: true, entry });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save score' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
