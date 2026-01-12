window.addEventListener("load", () => { 
	const headerLogo = document.getElementById("headerLogo");
    const headerLogin = document.getElementById('headerLogin');
	const headerLogout = document.getElementById('headerLogout');
    const headerOpenSidebar = document.getElementById('headerOpenSidebar');
    const headerCloseSidebar = document.getElementById('headerCloseSidebar');
    const headerSidebar = document.getElementById('headerSidebar');


	
	//로고 버튼 클릭 시
	if(headerLogo){
	    headerLogo.addEventListener("click", () => {
	        location.href = "/"; // 링크 수정 필요(메인 화면)
	    });
	}
	
	// 로그인 버튼 클릭 시 (로그인 버튼이 화면에 있을 때만)
	if (headerLogin) {
		headerLogin.addEventListener('click', () => {
			location.href = "/"; // 링크 수정 필요 (로그인 페이지)
		});
	}

	// 로그아웃 버튼 클릭 시 (로그아웃 버튼이 화면에 있을 때만)
	if (headerLogout) {
		headerLogout.addEventListener('click', () => {
			if(confirm("로그아웃 하시겠습니까?")) {
				location.href = "/"; // 링크 수정 필요 (로그아웃 처리(세션 삭제 로직 포함))
	    	}
		});
	}

	// 사이드바 토글
	if(headerOpenSidebar && headerCloseSidebar && headerSidebar){
		const toggleSidebar = () => headerSidebar.classList.toggle('active');
		headerOpenSidebar.addEventListener('click', toggleSidebar);
		headerCloseSidebar.addEventListener('click', toggleSidebar);
	}
	
	/*
	headerOpenSidebar, headerCloseSidebar, headerSidebar null 체크가 안 되어 있음 
	→ getElementById 실패 시 오류 날 수 있음
	*/

	
});