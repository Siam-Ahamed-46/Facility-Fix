document.addEventListener('DOMContentLoaded', () => {
  // Confirm password before registration is submitted.
  const registerForm = document.querySelector('form input[name="action"][value="register"]')?.form;
  const password = registerForm?.querySelector('input[name="password"]');
  const confirm = document.getElementById('confirmPassword');
  if (registerForm && password && confirm) {
    const validate = () => {
      confirm.setCustomValidity(confirm.value && confirm.value !== password.value
        ? 'Passwords do not match'
        : '');
    };
    password.addEventListener('input', validate);
    confirm.addEventListener('input', validate);
    registerForm.addEventListener('submit', validate);
  }

  // Preview selected issue photo before upload.
  const photoInput = document.getElementById('photoInput');
  const preview = document.getElementById('photoPreview');
  if (photoInput && preview) {
    photoInput.addEventListener('change', () => {
      preview.replaceChildren();
      const file = photoInput.files && photoInput.files[0];
      if (!file) {
        preview.hidden = true;
        return;
      }
      if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
        photoInput.value = '';
        preview.hidden = true;
        alert('Please choose a JPG, PNG, or WEBP image.');
        return;
      }
      if (file.size > 3 * 1024 * 1024) {
        photoInput.value = '';
        preview.hidden = true;
        alert('The image must be 3 MB or smaller.');
        return;
      }
      const img = document.createElement('img');
      img.alt = 'Selected issue photo preview';
      img.src = URL.createObjectURL(file);
      img.onload = () => URL.revokeObjectURL(img.src);
      preview.appendChild(img);
      preview.hidden = false;
    });
  }

  // Add a small dismissal interaction to system messages.
  document.querySelectorAll('.alert').forEach((message) => {
    message.setAttribute('role', 'status');
    message.addEventListener('dblclick', () => message.remove());
  });

  // Avoid accidental duplicate issue submission.
  document.querySelectorAll('form input[name="action"][value="report"]').forEach((hidden) => {
    const form = hidden.form;
    form?.addEventListener('submit', () => {
      const button = form.querySelector('button[type="submit"], button:not([type])');
      if (button && form.checkValidity()) {
        button.disabled = true;
        button.textContent = 'Submitting...';
      }
    });
  });
});

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-social]').forEach((button) => {
    button.addEventListener('click', () => {
      alert(button.dataset.social + ' sign-in is not configured yet. Please use your username/email and password.');
    });
  });
});
