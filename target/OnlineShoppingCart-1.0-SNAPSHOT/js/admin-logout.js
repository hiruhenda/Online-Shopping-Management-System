// Admin Logout Confirmation
(function() {
    'use strict';
    
    // Initialize modal system if not already loaded
    if (typeof ModalDialog === 'undefined') {
        console.error('ModalDialog is not loaded. Please include modal.js before admin-logout.js');
        return;
    }
    
    const modal = new ModalDialog();
    
    function confirmLogout(event) {
        event.preventDefault();
        
        const logoutUrl = event.currentTarget.getAttribute('href') || 
                         event.currentTarget.getAttribute('data-logout-url');
        
        modal.createModal({
            title: 'Confirm Logout',
            message: 'Are you sure you want to logout from the admin panel?',
            icon: 'warning',
            confirmText: 'Yes, Logout',
            cancelText: 'Cancel',
            confirmButtonClass: 'modal-btn-danger',
            onConfirm: function() {
                // Redirect to logout URL
                if (logoutUrl) {
                    window.location.href = logoutUrl;
                }
            },
            onCancel: function() {
                // Do nothing, just close modal
            }
        });
    }
    
    // Use event delegation to handle all logout button clicks
    document.addEventListener('click', function(event) {
        const logoutButton = event.target.closest('.admin-logout-btn');
        if (logoutButton) {
            confirmLogout(event);
        }
    });
})();
