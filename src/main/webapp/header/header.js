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
			location.href = contextPath + "/login/login_form.jsp"
		});
	}

	// 3. 로그아웃 버튼 클릭 시 -> 로그아웃 처리 페이지로 이동
	if (headerLogout) {
		headerLogout.addEventListener('click', (e) => {
			e.preventDefault(); // 링크 기본 동작 막기
			if (confirm("로그아웃 하시겠습니까?")) {
				location.href = contextPath + "/login/logout_action.jsp"; // 경로에 맞게 수정
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


document.addEventListener("DOMContentLoaded", function() {
    // 1. 현재 페이지의 전체 경로를 가져옵니다 (예: /project/store/store_main.jsp)
    const currentPath = window.location.pathname;

    // 2. 헤더 nav 내부의 모든 링크를 가져옵니다.
    const navLinks = document.querySelectorAll("header nav ul li a");

    navLinks.forEach(link => {
        // 3. 링크의 href 속성값을 가져옵니다.
        const linkPath = link.getAttribute("href");

        // 4. 현재 주소에 해당 링크의 경로가 포함되어 있는지 확인합니다.
        // (단순 포함 확인 시 메인페이지(/)가 중복될 수 있으므로 구체적으로 비교)
        if (currentPath.includes(linkPath)) {
            link.classList.add("active");
        }
		
		// 5. 예외 매칭: 상세 페이지(store_detail)에 있을 때 '맛집추천' 메뉴 활성화
        // '맛집추천' 링크의 href가 store_main.jsp를 포함하고 있는지 확인
        if (currentPath.includes("/store/") && linkPath.includes("store_main.jsp")) {
            link.classList.add("active");
        }
    });
});