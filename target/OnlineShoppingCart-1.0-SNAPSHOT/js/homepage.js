// Homepage Interactive JavaScript

// Hero Banner Carousel
let currentSlide = 0;
let carouselInterval;
const slideInterval = 6000; // 6 seconds

function showSlide(index) {
    const slides = document.querySelectorAll('.banner-slide');
    const indicators = document.querySelectorAll('.indicator');
    
    if (slides.length === 0) return;
    
    // Remove active class from all slides and indicators
    slides.forEach(slide => slide.classList.remove('active'));
    indicators.forEach(indicator => indicator.classList.remove('active'));
    
    // Add active class to current slide and indicator
    if (slides[index]) {
        slides[index].classList.add('active');
    }
    if (indicators[index]) {
        indicators[index].classList.add('active');
    }
}

function nextSlide() {
    const slides = document.querySelectorAll('.banner-slide');
    if (slides.length > 0) {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }
}

function startCarousel() {
    if (carouselInterval) {
        clearInterval(carouselInterval);
    }
    carouselInterval = setInterval(nextSlide, slideInterval);
}

// Loading Screen Handler
function hideLoadingScreen() {
    const loadingScreen = document.getElementById('loadingScreen');
    const body = document.body;
    
    if (loadingScreen && body) {
        // Remove loading class from body to reveal page content
        body.classList.remove('page-loading');
        body.style.overflow = 'auto'; // Enable scrolling
        
        // Smoothly fade out the loading screen
        loadingScreen.classList.add('hidden');
        
        // Remove from DOM after animation completes
        setTimeout(() => {
            if (loadingScreen && loadingScreen.parentNode) {
                loadingScreen.parentNode.removeChild(loadingScreen);
            }
        }, 800);
    }
}

// Check if this is the first visit to the home page
function isFirstVisit() {
    // Check localStorage to see if page has been visited before
    const hasVisited = localStorage.getItem('homePageVisited');
    return !hasVisited;
}

// Function to reset loading screen (for testing - can be called from browser console)
function resetLoadingScreen() {
    localStorage.removeItem('homePageVisited');
    location.reload();
}

// Initialize loading screen and carousel
document.addEventListener('DOMContentLoaded', () => {
    const loadingScreen = document.getElementById('loadingScreen');
    
    // ============================================
    // LOADING SCREEN - Completely separate from countdown
    // ============================================
    if (isFirstVisit()) {
        // First visit - show loading screen for 5 seconds and block page content
        console.log('First visit - showing loading screen for 5 seconds');
        
        // Mark as visited immediately
        localStorage.setItem('homePageVisited', 'true');
        
        // Ensure loading screen is visible and blocks the page
        if (loadingScreen) {
            const body = document.body;
            
            // Block page content by adding loading class
            if (body) {
                body.classList.add('page-loading');
                body.style.overflow = 'hidden'; // Prevent scrolling
            }
            
            // Ensure loading screen is fully visible
            loadingScreen.style.display = 'flex';
            loadingScreen.style.opacity = '1';
            loadingScreen.style.visibility = 'visible';
            loadingScreen.style.zIndex = '99999';
            
            // After 5 seconds, hide loading screen and reveal page
            setTimeout(() => {
                console.log('5 seconds passed - revealing index page');
                hideLoadingScreen();
            }, 5000);
        }
    } else {
        // Not first visit - hide immediately and show page
        console.log('Not first visit - showing page immediately');
        if (loadingScreen) {
            const body = document.body;
            if (body) {
                body.classList.remove('page-loading');
                body.style.overflow = 'auto';
            }
            loadingScreen.style.display = 'none';
            if (loadingScreen.parentNode) {
                loadingScreen.parentNode.removeChild(loadingScreen);
            }
        }
    }
    
    // ============================================
    // CAROUSEL - Separate functionality
    // ============================================
    const slides = document.querySelectorAll('.banner-slide');
    const indicators = document.querySelectorAll('.indicator');
    
    if (slides.length > 0) {
        showSlide(0);
        startCarousel();
        
        // Add click handlers to indicators
        indicators.forEach((indicator, index) => {
            indicator.addEventListener('click', () => {
                currentSlide = index;
                showSlide(currentSlide);
                startCarousel(); // Restart timer after manual navigation
            });
        });
        
        // Pause on hover, resume on leave
        const heroSection = document.querySelector('.hero-section');
        if (heroSection) {
            heroSection.addEventListener('mouseenter', () => {
                if (carouselInterval) {
                    clearInterval(carouselInterval);
                }
            });
            
            heroSection.addEventListener('mouseleave', () => {
                startCarousel();
            });
        }
    }
});


// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Intersection Observer for fade-in animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe elements for animation (excluding category cards)
document.addEventListener('DOMContentLoaded', () => {
    const animatedElements = document.querySelectorAll('.product-showcase-card, .feature-item');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});

// Quick view button functionality
document.querySelectorAll('.quick-view-btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        // Redirect to products page (can be enhanced with modal)
        window.location.href = 'products';
    });
});

// Category card click handler
document.querySelectorAll('.category-card').forEach(card => {
    card.addEventListener('click', function() {
        const category = this.getAttribute('data-category');
        window.location.href = `products?category=${category}`;
    });
});

// Header scroll effect
window.addEventListener('scroll', () => {
    const header = document.querySelector('.main-header');
    if (header) {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    }
    
    // Parallax effect to hero section
    const scrolled = window.pageYOffset;
    const heroSection = document.querySelector('.hero-section');
    if (heroSection && scrolled < heroSection.offsetHeight) {
        heroSection.style.transform = `translateY(${scrolled * 0.3}px)`;
    }
}, { passive: true });

// Mobile Hamburger Menu
document.addEventListener('DOMContentLoaded', () => {
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('navMenu');
    
    if (hamburger && navMenu) {
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
            document.body.style.overflow = navMenu.classList.contains('active') ? 'hidden' : '';
        });
        
        // Close menu when clicking on a link
        const navLinks = navMenu.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
                document.body.style.overflow = '';
            });
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
                document.body.style.overflow = '';
            }
        });
    }
});

// Add hover effect to product cards
document.querySelectorAll('.product-showcase-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-8px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
});


// Countdown Timer for Summer Sale
function initCountdownTimer() {
    // Set the end date for the sale (7 days from now)
    const endDate = new Date();
    endDate.setDate(endDate.getDate() + 7);
    endDate.setHours(23, 59, 59, 999); // End of day
    
    // Get countdown elements
    const daysElement = document.getElementById('days');
    const hoursElement = document.getElementById('hours');
    const minutesElement = document.getElementById('minutes');
    const secondsElement = document.getElementById('seconds');
    
    // Check if countdown elements exist
    if (!daysElement || !hoursElement || !minutesElement || !secondsElement) {
        return;
    }
    
    function updateCountdown() {
        const now = new Date().getTime();
        const distance = endDate.getTime() - now;
        
        // If countdown is over
        if (distance < 0) {
            daysElement.textContent = '00';
            hoursElement.textContent = '00';
            minutesElement.textContent = '00';
            secondsElement.textContent = '00';
            return;
        }
        
        // Calculate time units
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);
        
        // Update display with leading zeros
        daysElement.textContent = String(days).padStart(2, '0');
        hoursElement.textContent = String(hours).padStart(2, '0');
        minutesElement.textContent = String(minutes).padStart(2, '0');
        secondsElement.textContent = String(seconds).padStart(2, '0');
    }
    
    // Update immediately
    updateCountdown();
    
    // Update every second
    setInterval(updateCountdown, 1000);
}

// Initialize countdown timer when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    initCountdownTimer();
});
