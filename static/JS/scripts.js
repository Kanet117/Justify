// static/js/scripts.js
function abrirModal() {
    document.getElementById("modalPublicacion").style.display = "block";
}

function cerrarModal() {
    document.getElementById("modalPublicacion").style.display = "none";
}

function contarPalabras(textarea) {
    let texto = textarea.value.trim();
    let palabras = texto === "" ? 0 : texto.split(/\s+/).length;
    let contador = document.getElementById("contador");
    contador.textContent = `${palabras}/500 palabras`;
    if (palabras > 500) {
        contador.style.color = "red";
    } else {
        contador.style.color = "#666";
    }
}

window.onclick = function(event) {
    let modal = document.getElementById("modalPublicacion");
    if (event.target == modal) {
        modal.style.display = "none";
    }
}