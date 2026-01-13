// 정렬(Select Box) 변경 시에도 POST 방식을 유지하기 위해 form을 제출하도록 변경
function changeSort() {
	var sortVal = document.getElementById("sortFilter").value;

	// 1. form 안에 있는 hidden input 값을 내가 선택한 정렬값으로 바꿈
	// (주의: store_main.jsp에 name="sort"인 input이 있어야 함)
	document.querySelector('input[name="sort"]').value = sortVal;

	// 2. form 강제 제출 (이렇게 해야 POST로 전송되어 한글이 안 깨짐)
	// (주의: store_main.jsp에 class="search-box"인 form이 있어야 함)
	document.querySelector('.search-box').submit();
	
}