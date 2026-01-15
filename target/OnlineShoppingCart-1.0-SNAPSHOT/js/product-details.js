// Product Details Page Interactive Features

document.addEventListener('DOMContentLoaded', function() {
    const mainImage = document.getElementById('mainImage');
    const zoomLens = document.getElementById('zoomLens');
    const zoomContainer = document.getElementById('zoomContainer');
    const zoomImage = zoomContainer.querySelector('.zoom-image');
    const imageWrapper = document.querySelector('.product-image-wrapper');
    
    // Image Zoom Functionality
    if (mainImage && zoomLens && zoomContainer && imageWrapper) {
        let isZoomActive = false;
        
        imageWrapper.addEventListener('mouseenter', function() {
            isZoomActive = true;
            zoomContainer.classList.add('active');
        });
        
        imageWrapper.addEventListener('mouseleave', function() {
            isZoomActive = false;
            zoomLens.style.opacity = '0';
            zoomContainer.classList.remove('active');
        });
        
        imageWrapper.addEventListener('mousemove', function(e) {
            if (!isZoomActive) return;
            
            const rect = imageWrapper.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            // Calculate lens position (centered on cursor)
            const lensSize = 100;
            let lensX = x - lensSize / 2;
            let lensY = y - lensSize / 2;
            
            // Keep lens within bounds
            lensX = Math.max(0, Math.min(lensX, rect.width - lensSize));
            lensY = Math.max(0, Math.min(lensY, rect.height - lensSize));
            
            zoomLens.style.left = lensX + 'px';
            zoomLens.style.top = lensY + 'px';
            zoomLens.style.opacity = '1';
            
            // Calculate zoom (2x zoom)
            const zoom = 2;
            const zoomX = -(lensX * zoom);
            const zoomY = -(lensY * zoom);
            
            zoomImage.style.transform = `translate(${zoomX}px, ${zoomY}px) scale(${zoom})`;
        });
    }
    
    // Quantity Controls
    const quantityInput = document.getElementById('quantity');
    if (quantityInput) {
        quantityInput.addEventListener('change', function() {
            const value = parseInt(this.value);
            const max = parseInt(this.max);
            const min = parseInt(this.min);
            
            if (value > max) {
                this.value = max;
            } else if (value < min) {
                this.value = min;
            }
        });
    }
    
    // Add to Cart Form Submission with Feedback
    const addToCartForm = document.getElementById('addToCartForm');
    if (addToCartForm) {
        addToCartForm.addEventListener('submit', function(e) {
            const button = document.getElementById('addToCartBtn');
            const originalHTML = button.innerHTML;
            
            // Visual feedback
            button.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg> Added to Cart!';
            button.style.background = '#10b981';
            
            // Reset after 2 seconds (form will submit)
            setTimeout(() => {
                button.innerHTML = originalHTML;
                button.style.background = '';
            }, 2000);
        });
    }
    
    // Smooth scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observe sections
    const sections = document.querySelectorAll('.product-info-section > *');
    sections.forEach((section, index) => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = `opacity 0.5s ease ${index * 0.1}s, transform 0.5s ease ${index * 0.1}s`;
        observer.observe(section);
    });
});

// Quantity Control Functions
function increaseQuantity() {
    const input = document.getElementById('quantity');
    const max = parseInt(input.max);
    const current = parseInt(input.value);
    if (current < max) {
        input.value = current + 1;
    }
}

function decreaseQuantity() {
    const input = document.getElementById('quantity');
    const min = parseInt(input.min);
    const current = parseInt(input.value);
    if (current > min) {
        input.value = current - 1;
    }
}
