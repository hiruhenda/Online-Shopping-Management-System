// Checkout Page Interactive JavaScript

document.addEventListener('DOMContentLoaded', function() {
    const checkoutForm = document.getElementById('checkoutForm');
    const checkoutBtn = document.getElementById('checkoutBtn');
    
    if (!checkoutForm) return;
    
    // Form validation
    const formInputs = checkoutForm.querySelectorAll('input[required], textarea[required]');
    
    formInputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        input.addEventListener('input', function() {
            clearFieldError(this);
        });
    });
    
    // Form submission
    checkoutForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        let isValid = true;
        
        // Validate all fields
        formInputs.forEach(input => {
            if (!validateField(input)) {
                isValid = false;
            }
        });
        
        if (!isValid) {
            notifications.error('Please fill in all required fields correctly');
            
            // Focus on first error
            const firstError = checkoutForm.querySelector('.field-error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            return;
        }
        
        // Show loading state
        checkoutBtn.disabled = true;
        checkoutBtn.innerHTML = `
            <span>Processing...</span>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="animation: spin 1s linear infinite;">
                <path d="M12 2V6M12 18V22M6 12H2M22 12H18M19.07 19.07L16.24 16.24M19.07 4.93L16.24 7.76M4.93 19.07L7.76 16.24M4.93 4.93L7.76 7.76" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        `;
        
        // Submit form
        checkoutForm.submit();
    });
    
    function validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let errorMessage = '';
        
        // Required validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            errorMessage = getFieldLabel(field) + ' is required';
        }
        
        // Email validation
        if (field.type === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid email address';
            }
        }
        
        // Phone validation
        if (field.type === 'tel' && value) {
            const phoneRegex = /^[\d\s\-\+\(\)]+$/;
            if (!phoneRegex.test(value) || value.replace(/\D/g, '').length < 10) {
                isValid = false;
                errorMessage = 'Please enter a valid phone number';
            }
        }
        
        // Zip code validation
        if (field.id === 'zipCode' && value) {
            const zipRegex = /^\d{5}(-\d{4})?$/;
            if (!zipRegex.test(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid zip code';
            }
        }
        
        if (isValid) {
            clearFieldError(field);
            return true;
        } else {
            showFieldError(field, errorMessage);
            return false;
        }
    }
    
    function showFieldError(field, message) {
        clearFieldError(field);
        
        field.classList.add('field-error');
        
        const formGroup = field.closest('.form-group');
        if (!formGroup) return;
        
        const errorElement = document.createElement('div');
        errorElement.className = 'field-error-message';
        errorElement.textContent = message;
        errorElement.setAttribute('role', 'alert');
        
        formGroup.appendChild(errorElement);
        
        setTimeout(() => {
            errorElement.classList.add('show');
        }, 10);
    }
    
    function clearFieldError(field) {
        field.classList.remove('field-error');
        const formGroup = field.closest('.form-group');
        if (!formGroup) return;
        
        const errorMessage = formGroup.querySelector('.field-error-message');
        if (errorMessage) {
            errorMessage.classList.remove('show');
            setTimeout(() => {
                if (errorMessage.parentNode) {
                    errorMessage.parentNode.removeChild(errorMessage);
                }
            }, 300);
        }
    }
    
    function getFieldLabel(field) {
        const label = field.closest('.form-group')?.querySelector('.form-label');
        if (label) {
            return label.textContent.trim();
        }
        return field.name.charAt(0).toUpperCase() + field.name.slice(1);
    }
    
    // Show server-side errors if present
    const errorMessage = document.querySelector('.error-message');
    if (errorMessage) {
        const message = errorMessage.textContent.trim();
        notifications.error(message);
        errorMessage.style.display = 'none';
    }
    
    // Add spin animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
    `;
    document.head.appendChild(style);
});
