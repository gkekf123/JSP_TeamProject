/* ===== DOM 캐싱 ===== */
const bg = document.getElementById('bg');

/* ===== 배경 이미지 ===== */
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

//랜덤+중복 없게
//index와 lastIndex 값이 같으면 중복으로 처리함
//index 값이 0~n이므로 0미만의 숫자로
let lastIndex = -1;

function changeBg() {
  let index;

  do {
    index = Math.floor(Math.random() * images.length);
	//images.length 값이 3이면 
	//Math.random() * images.length은 0.xx~2.xx
	//Math.floor(...)는 소수점 이하 버려서 정수로 만듦
	//그러므로 index는 0~2 중 랜덤으로 나옴
  } while (index === lastIndex); 
  //값이 같으면 true 반환 -> 중복이므로 index 값 다시 뽑기

  lastIndex = index; //이전 index 저장, 다음 이미지 뽑을때 사용-중복 처리하려고
  bg.style.backgroundImage = `url(${images[index]})`;
}

changeBg();
setInterval(changeBg, 4000); //4초마다 변경
