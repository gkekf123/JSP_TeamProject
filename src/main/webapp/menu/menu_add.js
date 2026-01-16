function openEditMenuModal(menuIdx, menuName, menuPrice, menuImg) {

    document.getElementById("menuIdx").value = menuIdx;
    document.getElementById("menuName").value = menuName;
    document.getElementById("menuPrice").value = menuPrice;

    if (menuImg) {
        const preview = document.getElementById("menuPreview");
        preview.src = "<%= ctxPath %>/images/menu/" + menuImg;
        preview.style.display = "block";
    }

    document.getElementById("menuModalTitle").innerText = "메뉴 수정";

    new bootstrap.Modal(
        document.getElementById("menuAddModal")
    ).show();
}