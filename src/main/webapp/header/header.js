window.addEventListener("load", () => {
	const headerLogo = document.getElementById("headerLogo");
	const headerLogin = document.getElementById('headerLogin');
	const headerLogout = document.getElementById('headerLogout');

	// 사이드바 관련 변수
	const headerOpenSidebar = document.getElementById('headerOpenSidebar');
	const headerCloseSidebar = document.getElementById('headerCloseSidebar');
	const headerSidebar = document.getElementById('headerSidebar');

	// 1. 로고 클릭 시 -> 메인으로 이동
	if (headerLogo) {
		headerLogo.addEventListener("click", () => {
			// contextPath 변수를 사용해서 정확한 경로로 이동
			location.href = contextPath + "/index.jsp";
		});
	}

	// 2. 로그인 버튼 클릭 시 -> 로그인 페이지로 이동
	if (headerLogin) {
		headerLogin.addEventListener('click', () => {
			location.href = contextPath + "/member/login.jsp"; // 경로에 맞게 수정
		});
	}

	// 3. 로그아웃 버튼 클릭 시 -> 로그아웃 처리 페이지로 이동
	if (headerLogout) {
		headerLogout.addEventListener('click', () => {
			if (confirm("로그아웃 하시겠습니까?")) {
				location.href = contextPath + "/member/logout.jsp"; // 경로에 맞게 수정
			}
		});
	}

	// 4. 사이드바 토글 (Null 체크 추가로 안전하게)
	if (headerOpenSidebar && headerCloseSidebar && headerSidebar) {
		const toggleSidebar = () => headerSidebar.classList.toggle('active');
		headerOpenSidebar.addEventListener('click', toggleSidebar);
		headerCloseSidebar.addEventListener('click', toggleSidebar);
	}
});