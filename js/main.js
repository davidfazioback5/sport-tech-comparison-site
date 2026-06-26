/* ClubTech Compare — Shared JS */

// Mobile nav toggle
document.addEventListener('DOMContentLoaded', () => {
  const hamburger = document.querySelector('.hamburger');
  const header    = document.querySelector('.site-header');
  if (hamburger) {
    hamburger.addEventListener('click', () => header.classList.toggle('nav-open'));
  }

  // Active nav link
  const path = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-links a').forEach(link => {
    if (link.getAttribute('href') === path) link.classList.add('active');
  });

  // Animate rating bars on scroll
  const observer = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.querySelectorAll('.rating-bar-fill').forEach(bar => {
          bar.style.width = bar.dataset.width;
        });
        observer.unobserve(e.target);
      }
    });
  }, { threshold: 0.2 });

  document.querySelectorAll('.rating-bars').forEach(el => {
    el.querySelectorAll('.rating-bar-fill').forEach(bar => {
      bar.style.width = '0%';
    });
    observer.observe(el);
  });

  // Lead capture forms — show thank-you
  document.querySelectorAll('.lead-form form, .email-form').forEach(form => {
    form.addEventListener('submit', e => {
      e.preventDefault();
      const btn = form.querySelector('button[type="submit"], .btn');
      if (btn) {
        btn.textContent = '✓ Got it — check your inbox!';
        btn.disabled = true;
        btn.style.opacity = '0.7';
      }
    });
  });
});

// UTM passthrough — preserve UTM params on all internal links
(function() {
  const params = new URLSearchParams(window.location.search);
  const utmKeys = ['utm_source','utm_medium','utm_campaign','utm_content','utm_term'];
  const hasUtm  = utmKeys.some(k => params.has(k));
  if (!hasUtm) return;
  const utmString = utmKeys.filter(k => params.has(k)).map(k => `${k}=${encodeURIComponent(params.get(k))}`).join('&');
  document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('a[href]').forEach(a => {
      const href = a.getAttribute('href');
      if (href && !href.startsWith('http') && !href.startsWith('#') && !href.startsWith('mailto')) {
        a.href = href + (href.includes('?') ? '&' : '?') + utmString;
      }
    });
  });
})();
