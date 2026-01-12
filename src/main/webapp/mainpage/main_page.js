const bg = document.getElementById('bg');

/* 배경 이미지 */
const images = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
	'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
	'https://images.unsplash.com/photo-1550547660-d9450f859349',
	'https://images.unsplash.com/photo-1543353071-873f17a7a088',
	'https://images.unsplash.com/photo-1473093295043-cdd812d0e601',
	'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
	'https://images.unsplash.com/photo-1498654896293-37aacf113fd9',
	'https://images.unsplash.com/photo-1509042239860-f550ce710b93'
];

let index = 0;

function changeBg() {
    bg.style.backgroundImage = `url(${images[index]})`;
    index = (index + 1) % images.length;
}
changeBg();
setInterval(changeBg, 4000); //4초마다 변경
