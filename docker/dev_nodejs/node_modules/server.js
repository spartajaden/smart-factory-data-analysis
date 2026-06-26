const express = require('express');
const path = require('path');

const app = express();
const PORT = 3300;

// Serve static files from the 'dist' directory
const distPath = path.join(__dirname, 'dist');
app.use(express.static(distPath));

// Fallback to index.html for SPA routing
app.get('/', (req, res) => {
	res.sendFile(path.join(distPath, 'index.html'));
});

app.listen(PORT, () => {
	console.log(`Server is running on http://localhost:${PORT}`);
});

