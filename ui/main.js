 function showFadeBox(data) {
	  let imageSrc =data[0];
	  let message=data[1];
	  let duration =data[2];
  const fadeBox = document.getElementById("fadeBox");
  const img = document.getElementById("myImage");
  const msg = document.getElementById("message");

  img.src = imageSrc;
  msg.textContent = message;

  // Fade in
  fadeBox.classList.add("show");

  // Fade out after duration
  setTimeout(() => {
    fadeBox.classList.remove("show");
  }, duration *1000);
}
function playerstats([rank, assault, engi, support, recon, kills, deaths]) {
	const id = String(Math.min(Math.max(rank, 1), 100)).padStart(3, '0');
  const icons = [
    {img:`fb://UI/Art/Persistence/Ranks/Icons/RankS${id}`, txt:`Rank ${rank}`},
    {img:"images/Assault.png", txt:assault, star:true},
    {img:"images/Engineer.png", txt:engi, star:true},
    {img:"images/Support.png", txt:support, star:true},
    {img:"images/Recon.png", txt:recon, star:true},
    {img:"images/Main_Kills.png", txt:kills},
    {img:"images/rip.png", txt:deaths}
  ];

const html = `<div class="playerstats-flex">` +
    icons.map((i, idx) => `
      <div class="playerstats-item">
        <img src="${i.img}">
        ${i.star ? `<img src="images/servicestar.png">` : ""}
        ${i.txt}
        ${idx < icons.length - 1 ? `<hr class="playerstats-sep">` : ""}
      </div>`).join('') +
    `</div>`;

  document.getElementById("playerstats").innerHTML = html;
}
function showBox() {
      document.getElementById("playerstats").style.display = "block";
    }

    function hideBox() {
      document.getElementById("playerstats").style.display = "none";
    }

    function toggleBox() {
      let box = document.getElementById("playerstats");
      if (box.style.display === "none" || box.style.display === "") {
        box.style.display = "block";
      } else {
        box.style.display = "none";
      }
    }
	 // play a sound using webui
function playSound(file,volume) {
	const audio = document.createElement("audio");
	audio.src = file;
	audio.volume = volume; //1.0 means highest volume (100%. This is default)
	audio.autoplay = true;
	audio.controls = false;
	audio.addEventListener("ended", () => audio.remove());
	document.body.appendChild(audio);
}
// individual sound effects

async function vuplayCustomSound(path, delay = 0, volume = 1) {
    if (delay > 0) { await sleep(delay); }
    playSound('sounds/' + path + '.ogg', volume);
}
function sleep(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}
// test data
//const sta=['12','doc','54','34','54','32','32']
//playerstats(sta)
//hideBox()
//const args = ["images/Dead-Black.png", "Mission Complete!",10];
//showFadeBox(args);