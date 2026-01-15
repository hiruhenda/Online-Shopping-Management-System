// Form Validation with Interactive Feedback

class FormValidator {
    constructor(formId) {
        this.form = document.getElementById(formId);
        this.fields = {};
        this.init();
    }

    init() {
        if (!this.form) return;
        
        // Get all input fields
        const inputs = this.form.querySelectorAll('input, textarea');
        inputs.forEach(input => {
            if (input.type !== 'submit' && input.type !== 'button') {
                this.fields[input.name] = input;
                this.setupFieldValidation(input);
            }
        });
        
        // Form submission validation
        this.form.addEventListener('submit', (e) => {
            if (!this.validateForm()) {
                e.preventDefault();
            }
        });
    }

    setupFieldValidation(input) {
        // Real-time validation on blur
        input.addEventListener('blur', () => {
            this.validateField(input);
        });
        
        // Clear error on input
        input.addEventListener('input', () => {
            this.clearFieldError(input);
        });
    }

    validateField(field) {
        const value = field.value.trim();
        const fieldName = field.name;
        let isValid = true;
        let errorMessage = '';

        // Required validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            errorMessage = this.getFieldLabel(field) + ' is required';
        }
        
        // Email validation
        if (fieldName === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid email address';
            }
        }
        
        // Username validation
        if (fieldName === 'username' && value) {
            if (value.length < 3) {
                isValid = false;
                errorMessage = 'Username must be at least 3 characters';
            } else if (!/^[a-zA-Z0-9_]+$/.test(value)) {
                isValid = false;
                errorMessage = 'Username can only contain letters, numbers, and underscores';
            }
        }
        
        // Password validation
        if (fieldName === 'password' && value) {
            if (value.length < 6) {
                isValid = false;
                errorMessage = 'Password must be at least 6 characters';
            }
        }
        
        // Phone validation
        if (fieldName === 'phone' && value) {
            const phoneRegex = /^[\d\s\-\+\(\)]+$/;
            if (!phoneRegex.test(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid phone number';
            }
        }
        
        // Quantity validation
        if (fieldName === 'quantity' && value) {
            const num = parseInt(value);
            const min = parseInt(field.getAttribute('min')) || 1;
            const max = parseInt(field.getAttribute('max')) || 999;
            if (isNaN(num) || num < min || num > max) {
                isValid = false;
                errorMessage = `Quantity must be between ${min} and ${max}`;
            }
        }

        if (isValid) {
            this.clearFieldError(field);
            return true;
        } else {
            this.showFieldError(field, errorMessage);
            return false;
        }
    }

    validateForm() {
        let isValid = true;
        
        Object.values(this.fields).forEach(field => {
            if (!this.validateField(field)) {
                isValid = false;
            }
        });
        
        if (!isValid) {
            notifications.error('Please fix the errors in the form');
        }
        
        return isValid;
    }

    showFieldError(field, message) {
        this.clearFieldError(field);
        
        field.classList.add('field-error');
        
        // Find the form-group container
        let container = field.parentNode;
        if (!container.classList.contains('form-group') && !container.classList.contains('input-wrapper')) {
            container = container.closest('.form-group') || container.closest('.input-wrapper') || field.parentNode;
        }
        
        const errorElement = document.createElement('div');
        errorElement.className = 'field-error-message';
        errorElement.textContent = message;
        errorElement.setAttribute('role', 'alert');
        
        container.appendChild(errorElement);
        
        // Animate error
        setTimeout(() => {
            errorElement.classList.add('show');
        }, 10);
    }

    clearFieldError(field) {
        field.classList.remove('field-error');
        
        // Find the form-group container
        let container = field.parentNode;
        if (!container.classList.contains('form-group') && !container.classList.contains('input-wrapper')) {
            container = container.closest('.form-group') || container.closest('.input-wrapper') || field.parentNode;
        }
        
        const errorMessage = container.querySelector('.field-error-message');
        if (errorMessage) {
            errorMessage.classList.remove('show');
            setTimeout(() => {
                if (errorMessage.parentNode) {
                    errorMessage.parentNode.removeChild(errorMessage);
                }
            }, 300);
        }
    }

    getFieldLabel(field) {
        const label = field.parentNode.querySelector('label');
        if (label) {
            return label.textContent.trim();
        }
        const placeholder = field.getAttribute('placeholder');
        if (placeholder) {
            return placeholder;
        }
        return field.name.charAt(0).toUpperCase() + field.name.slice(1);
    }
}

// Initialize validators for forms
document.addEventListener('DOMContentLoaded', function() {
    if (document.getElementById('registerForm')) {
        new FormValidator('registerForm');
    }
    if (document.getElementById('loginForm')) {
        new FormValidator('loginForm');
    }
    if (document.getElementById('addToCartForm')) {
        new FormValidator('addToCartForm');
    }
});
