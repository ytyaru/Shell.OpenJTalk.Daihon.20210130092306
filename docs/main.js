window.addEventListener('load', (event) => {
    console.log('HelloJS');
    Player.addEventListener();
    /*
    // https://developer.mozilla.org/ja/docs/Web/API/HTMLMediaElement/ended_event
    const audioTags = document.querySelectorAll('audio');
    const REGEXP_PATH = /(.+)\/([0-9]+)\.(wav|mp3|ogg|flac)/
    for (let audioTag of audioTags) {
        audioTag.addEventListener('ended', (event) => {
            const oldSrc = event.target.src;
            let index = 0;
            event.target.src = event.target.src.replace(REGEXP_PATH, (match, dir, name, ext)=>{
                index = Number(name);
                index++;
                if (Number(event.target.getAttribute('last')) < index) { index = 0; }
                return dir + '/' + index + '.' + ext;
            });
            console.log(index);
            if (0 < index) { event.target.play(); }
        });
    }
    */
});

