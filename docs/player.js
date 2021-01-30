class Player { //<audio> src="0.mp3" から 順に再生する。ファイル名をインクリメントする。last=""属性値の値まできたら0に戻して停止。
    static REGEXP_PATH = /(.+)\/([0-9]+)\.(wav|mp3|ogg|flac)/
    static CSS_SELECTOR_PLAYLIST = '#playlist';
    static addEventListener() {
        const audioTags = document.querySelectorAll('audio');
        for (let audioTag of audioTags) {
            const span = document.createElement('span');
            document.querySelector(Player.CSS_SELECTOR_PLAYLIST).appendChild(span);
            Player.#setSpan(audioTag);
            audioTag.addEventListener('ended', (event) => {
                const oldSrc = event.target.src;
                let index = 0;
                event.target.src = event.target.src.replace(Player.REGEXP_PATH, (match, dir, name, ext)=>{
                    index = Number(name);
                    index++;
                    if (Number(event.target.getAttribute('last')) < index) { index = 0; }
                    return dir + '/' + index + '.' + ext;
                });
                console.log(index);
                Player.#setSpan(event.target);
                if (0 < index) { event.target.play(); }
            });
        }
    }
    static #getFileId(audioTag) {
        return audioTag.src.replace(Player.REGEXP_PATH, (match, dir, name, ext)=>{
            return Number(name);
        });
    }
    static #setSpan(audioTag) {
        document.querySelector(Player.CSS_SELECTOR_PLAYLIST).children[0].textContent = Player.#getFileId(audioTag)+'/'+audioTag.getAttribute('last');
    }
}
