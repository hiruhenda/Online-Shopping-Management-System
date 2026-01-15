// Modal Dialog System

class ModalDialog {
    constructor() {
        this.overlay = null;
        this.dialog = null;
    }

    createModal(options = {}) {
        const {
            title = 'Confirm',
            message = 'Are you sure?',
            icon = 'warning',
            confirmText = 'Confirm',
            cancelText = 'Cancel',
            onConfirm = null,
            onCancel = null,
            confirmButtonClass = 'modal-btn-primary'
        } = options;

        // Remove existing modal if any
        this.close();

        // Create overlay
        this.overlay = document.createElement('div');
        this.overlay.className = 'modal-overlay';
        this.overlay.id = 'modalOverlay';

        // Create dialog
        this.dialog = document.createElement('div');
        this.dialog.className = 'modal-dialog';

        // Icon SVG
        let iconSvg = '';
        switch(icon) {
            case 'warning':
                iconSvg = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 9V13M12 17H12.01M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
                break;
            case 'error':
                iconSvg = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
                break;
            case 'success':
                iconSvg = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
                break;
            default:
                iconSvg = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13 16H12V12H11M12 8H12.01M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
        }

        // Build modal HTML
        this.dialog.innerHTML = `
            <div class="modal-header">
                <div class="modal-icon ${icon}">
                    ${iconSvg}
                </div>
                <h3 class="modal-title">${title}</h3>
            </div>
            <div class="modal-body">
                <p class="modal-message">${message}</p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-secondary" id="modalCancelBtn">
                    ${cancelText}
                </button>
                <button class="modal-btn ${confirmButtonClass}" id="modalConfirmBtn">
                    ${confirmText}
                </button>
            </div>
        `;

        this.overlay.appendChild(this.dialog);
        document.body.appendChild(this.overlay);

        // Add event listeners
        const confirmBtn = this.dialog.querySelector('#modalConfirmBtn');
        const cancelBtn = this.dialog.querySelector('#modalCancelBtn');

        confirmBtn.addEventListener('click', () => {
            if (onConfirm && typeof onConfirm === 'function') {
                onConfirm();
            }
            this.close();
        });

        cancelBtn.addEventListener('click', () => {
            if (onCancel && typeof onCancel === 'function') {
                onCancel();
            }
            this.close();
        });

        // Close on overlay click
        this.overlay.addEventListener('click', (e) => {
            if (e.target === this.overlay) {
                if (onCancel && typeof onCancel === 'function') {
                    onCancel();
                }
                this.close();
            }
        });

        // Close on Escape key
        const escapeHandler = (e) => {
            if (e.key === 'Escape') {
                if (onCancel && typeof onCancel === 'function') {
                    onCancel();
                }
                this.close();
                document.removeEventListener('keydown', escapeHandler);
            }
        };
        document.addEventListener('keydown', escapeHandler);

        // Show modal with animation
        setTimeout(() => {
            this.overlay.classList.add('show');
        }, 10);

        return this;
    }

    close() {
        if (this.overlay) {
            this.overlay.classList.remove('show');
            setTimeout(() => {
                if (this.overlay && this.overlay.parentNode) {
                    this.overlay.parentNode.removeChild(this.overlay);
                }
                this.overlay = null;
                this.dialog = null;
            }, 300);
        }
    }

    // Convenience methods
    confirm(options) {
        return this.createModal({
            icon: 'warning',
            confirmButtonClass: 'modal-btn-primary',
            ...options
        });
    }

    alert(options) {
        return this.createModal({
            icon: 'info',
            confirmText: 'OK',
            cancelText: '',
            confirmButtonClass: 'modal-btn-primary',
            ...options
        });
    }

    error(options) {
        return this.createModal({
            icon: 'error',
            confirmText: 'OK',
            cancelText: '',
            confirmButtonClass: 'modal-btn-danger',
            ...options
        });
    }

    success(options) {
        return this.createModal({
            icon: 'success',
            confirmText: 'OK',
            cancelText: '',
            confirmButtonClass: 'modal-btn-primary',
            ...options
        });
    }
}

// Initialize modal system
const modal = new ModalDialog();

// Logout confirmation handler
document.addEventListener('DOMContentLoaded', function() {
    const logoutLinks = document.querySelectorAll('a[href="logout"], a[href*="logout"]');
    
    logoutLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const logoutUrl = this.getAttribute('href');
            
            modal.confirm({
                title: 'Confirm Logout',
                message: 'Are you sure you want to logout? You will need to login again to access your account.',
                icon: 'warning',
                confirmText: 'Yes, Logout',
                cancelText: 'Cancel',
                confirmButtonClass: 'modal-btn-danger',
                onConfirm: function() {
                    // Redirect to logout
                    window.location.href = logoutUrl;
                },
                onCancel: function() {
                    // User cancelled, do nothing
                }
            });
        });
    });
});
