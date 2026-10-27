document.addEventListener('DOMContentLoaded',()=>{document.querySelectorAll('[data-count-up]').forEach(el=>{const target=Number(el.dataset.countUp||0);el.textContent=String(target);});});
