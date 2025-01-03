let currentTrackId = null;

async function uploadTrack() {
    const fileInput = document.getElementById('audioFile');
    const file = fileInput.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append('track[audio]', file);

    try {
        const response = await fetch('/api/tracks', {
            method: 'POST',
            body: formData
        });
        const data = await response.json();
        currentTrackId = data.id;
        document.getElementById('audioPlayer').src = data.audio_url;
        console.log('Track uploaded successfully');
    } catch (error) {
        console.error('Error uploading track:', error);
    }
}

async function playTrack() {
    if (!currentTrackId) {
        console.log('No track selected');
        return;
    }
    try {
        await fetch(`/api/tracks/${currentTrackId}/play`, { method: 'PUT' });
        document.getElementById('audioPlayer').play();
        console.log('Track playing');
    } catch (error) {
        console.error('Error playing track:', error);
    }
}

async function pauseTrack() {
    if (!currentTrackId) {
        console.log('No track selected');
        return;
    }
    try {
        await fetch(`/api/tracks/${currentTrackId}/pause`, { method: 'PUT' });
        document.getElementById('audioPlayer').pause();
        console.log('Track paused');
    } catch (error) {
        console.error('Error pausing track:', error);
    }
}

async function stopTrack() {
    if (!currentTrackId) {
        console.log('No track selected');
        return;
    }
    try {
        await fetch(`/api/tracks/${currentTrackId}/stop`, { method: 'PUT' });
        const audioPlayer = document.getElementById('audioPlayer');
        audioPlayer.pause();
        audioPlayer.currentTime = 0;
        console.log('Track stopped');
    } catch (error) {
        console.error('Error stopping track:', error);
    }
}

// Initialize audio player
document.addEventListener('DOMContentLoaded', () => {
    const audioPlayer = document.getElementById('audioPlayer');
    audioPlayer.addEventListener('ended', () => {
        console.log('Track finished playing');
        // You can add additional logic here, like playing the next track
    });
});
