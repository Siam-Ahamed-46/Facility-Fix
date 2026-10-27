document.addEventListener('DOMContentLoaded', () => {
  const landing = document.getElementById('lampLanding');
  const pull = document.getElementById('lampPull');
  const copy = document.getElementById('landingCopy');
  const instruction = document.getElementById('pullInstruction');

  if (landing && pull && copy) {
    const switchOn = () => {
      if (landing.classList.contains('lamp-is-lit')) return;
      landing.classList.add('lamp-is-lit');
      copy.hidden = false;
      pull.setAttribute('aria-label', 'Lamp is on');
      if (instruction) instruction.textContent = 'Light is on';
    };
    pull.addEventListener('click', switchOn);
  }

  const trigger = document.getElementById('featuresTrigger');
  const drawer = document.getElementById('featuresDrawer');
  const close = document.getElementById('featuresClose');
  if (trigger && drawer) {
    const setOpen = (open) => {
      drawer.hidden = !open;
      trigger.setAttribute('aria-expanded', String(open));
    };
    trigger.addEventListener('click', () => setOpen(drawer.hidden));
    if (close) close.addEventListener('click', () => setOpen(false));
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape') setOpen(false);
    });
  }
});
