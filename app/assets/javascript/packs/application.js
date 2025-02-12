//= require jquery
//= require select2
//= require_tree .

document.addEventListener("DOMContentLoaded", () => {
  // Parallax scroll effect
  function parallaxScroll() {
    const parallaxSections = document.querySelectorAll('.parallax');

    parallaxSections.forEach((section) => {
      const speed = section.getAttribute('data-speed') || 0.5; // Default speed is 0.5
      const offset = window.pageYOffset; // Scroll position

      // Change the background position based on scroll
      section.style.backgroundPosition = `center ${offset * speed}px`;
    });
  }

  // Call the parallaxScroll function on scroll event
  window.addEventListener('scroll', parallaxScroll);

  // Optional: Smooth scroll behavior for anchor links
  const links = document.querySelectorAll('a[href^="#"]');
  links.forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      document.querySelector(link.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });
});
