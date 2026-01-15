// Register Page Interactive JavaScript

document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordStrength = document.getElementById('passwordStrength');
    const strengthFill = document.getElementById('strengthFill');
    const strengthText = document.getElementById('strengthText');
    const registerForm = document.getElementById('registerForm');
    const registerBtn = document.getElementById('registerBtn');
    const formInputs = document.querySelectorAll('.form-input');
    
    // Password Toggle Functionality
    if (passwordToggle && passwordInput) {
        passwordToggle.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Update icon
            const icon = passwordToggle.querySelector('svg');
            if (type === 'text') {
                icon.innerHTML = `
                    <path d="M17.94 17.94C16.2306 19.243 14.1491 19.9649 12 20C5 20 1 12 1 12C2.24389 9.68192 3.96914 7.65663 6.06 6.06M9.9 4.24C10.5883 4.07888 11.2931 3.99834 12 4C19 4 23 12 23 12C22.393 13.1356 21.6691 14.2047 20.84 15.19M14.12 14.12C13.8454 14.4147 13.5141 14.6511 13.1462 14.8151C12.7782 14.9791 12.3809 15.0673 11.9781 15.0744C11.5753 15.0815 11.1751 15.0073 10.8016 14.8565C10.4281 14.7057 10.0887 14.4811 9.80385 14.1962C9.51897 13.9113 9.29426 13.5719 9.14351 13.1984C8.99275 12.8249 8.91854 12.4247 8.92563 12.0219C8.93272 11.6191 9.02091 11.2218 9.18488 10.8538C9.34884 10.4858 9.58525 10.1546 9.88 9.88" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M1 1L23 23" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                `;
            } else {
                icon.innerHTML = `
                    <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                `;
            }
        });
    }
    
    // Password Strength Meter
    if (passwordInput && passwordStrength && strengthFill && strengthText) {
        passwordInput.addEventListener('input', function() {
            const password = passwordInput.value;
            
            if (password.length === 0) {
                passwordStrength.classList.remove('active');
                return;
            }
            
            passwordStrength.classList.add('active');
            
            let strength = 0;
            let strengthLabel = '';
            let strengthColor = '';
            
            // Length check
            if (password.length >= 8) strength += 25;
            if (password.length >= 12) strength += 10;
            
            // Character variety checks
            if (/[a-z]/.test(password)) strength += 15;
            if (/[A-Z]/.test(password)) strength += 15;
            if (/[0-9]/.test(password)) strength += 15;
            if (/[^a-zA-Z0-9]/.test(password)) strength += 20;
            
            // Determine strength level
            if (strength < 30) {
                strengthLabel = 'Weak';
                strengthColor = '#e74c3c';
            } else if (strength < 60) {
                strengthLabel = 'Fair';
                strengthColor = '#f39c12';
            } else if (strength < 80) {
                strengthLabel = 'Good';
                strengthColor = '#3498db';
            } else {
                strengthLabel = 'Strong';
                strengthColor = '#27ae60';
            }
            
            // Update UI
            strengthFill.style.width = strength + '%';
            strengthFill.style.background = strengthColor;
            strengthText.textContent = `Password strength: ${strengthLabel}`;
            strengthText.style.color = strengthColor;
            
            // Add visual feedback to input
            passwordInput.classList.remove('error', 'success');
            if (strength < 30) {
                passwordInput.classList.add('error');
            } else if (strength >= 60) {
                passwordInput.classList.add('success');
            }
        });
    }
    
    // Form Input Animations
    formInputs.forEach(input => {
        // Add focus animation
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.transition = 'transform 0.3s ease';
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
        
        // Real-time validation
        input.addEventListener('input', function() {
            validateField(this);
        });
        
        input.addEventListener('blur', function() {
            validateField(this);
        });
    });
    
    // Field Validation Function
    function validateField(field) {
        const value = field.value.trim();
        const fieldType = field.type;
        const fieldName = field.name;
        
        field.classList.remove('error', 'success');
        
        if (field.hasAttribute('required') && value === '') {
            field.classList.add('error');
            return false;
        }
        
        if (value === '') {
            return true; // Empty optional fields are valid
        }
        
        let isValid = true;
        
        // Email validation
        if (fieldType === 'email') {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            isValid = emailRegex.test(value);
        }
        
        // Phone validation
        if (fieldType === 'tel') {
            const phoneRegex = /^[\d\s\-\+\(\)]+$/;
            isValid = phoneRegex.test(value) && value.replace(/\D/g, '').length >= 10;
        }
        
        // Username validation (alphanumeric and underscore, 3-20 chars)
        if (fieldName === 'username') {
            const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
            isValid = usernameRegex.test(value);
        }
        
        // Password validation (already handled by strength meter)
        if (fieldType === 'password') {
            isValid = value.length >= 8;
        }
        
        if (isValid) {
            field.classList.add('success');
        } else {
            field.classList.add('error');
        }
        
        return isValid;
    }
    
    // Form Submission Handler
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate all fields
            formInputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                
                // Show error notification
                notifications.error('Please fill in all required fields correctly');
                
                // Show error animation
                registerBtn.style.animation = 'shake 0.5s ease';
                setTimeout(() => {
                    registerBtn.style.animation = '';
                }, 500);
                
                // Focus on first error
                const firstError = registerForm.querySelector('.form-input.error');
                if (firstError) {
                    firstError.focus();
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } else {
                // Show loading state
                registerBtn.disabled = true;
                registerBtn.innerHTML = `
                    <span class="btn-text">Creating Account...</span>
                    <svg class="btn-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="animation: spin 1s linear infinite;">
                        <path d="M12 2V6M12 18V22M6 12H2M22 12H18M19.07 19.07L16.24 16.24M19.07 4.93L16.24 7.76M4.93 19.07L7.76 16.24M4.93 4.93L7.76 7.76" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                `;
            }
        });
    }
    
    // Add shake animation for errors
    const style = document.createElement('style');
    style.textContent = `
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
    `;
    document.head.appendChild(style);
    
    // Smooth scroll to form on page load if there are errors
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('error')) {
        setTimeout(() => {
            registerForm.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }, 300);
    }
    
    // Add floating label animation on page load for pre-filled fields
    formInputs.forEach(input => {
        if (input.value !== '') {
            input.dispatchEvent(new Event('input'));
        }
    });
    
    // Add ripple effect to button
    if (registerBtn) {
        registerBtn.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            ripple.classList.add('ripple');
            
            this.appendChild(ripple);
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    }
});
