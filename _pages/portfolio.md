---
layout: page
title: Portfolio
permalink: /portfolio/
---

This portfolio is a selection of projects I've built, reflecting my work with AI tools, credit and payments (SaaS and B2C).  


<div class="portfolio-controls">
  {% include view-toggle.html label="Portfolio view toggle" %}
</div>

{% assign projects = site.projects | sort: "order" %}

<div class="view-panel view-cards is-active">
  <div class="posts post-list">
    {% for project in projects %}
      {% include project-card.html project=project %}
    {% endfor %}
  </div>
</div>

<div class="view-panel view-list">
  <div class="project-list-simple">
    {% for project in projects %}
      {% include project-row.html project=project %}
    {% endfor %}
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    var buttons = document.querySelectorAll('.view-toggle-btn');
    var panels = document.querySelectorAll('.view-panel');
    if (!buttons.length || !panels.length) return;

    function setView(view) {
      panels.forEach(function (panel) {
        panel.classList.toggle('is-active', panel.classList.contains('view-' + view));
      });
      buttons.forEach(function (btn) {
        var active = btn.dataset.view === view;
        btn.classList.toggle('is-active', active);
        btn.setAttribute('aria-pressed', active ? 'true' : 'false');
      });
      try {
        window.localStorage.setItem('portfolioView', view);
      } catch (e) {}
    }

    buttons.forEach(function (btn) {
      btn.addEventListener('click', function () {
        setView(btn.dataset.view);
      });
    });

    try {
      var stored = window.localStorage.getItem('portfolioView');
      if (stored === 'list' || stored === 'cards') {
        setView(stored);
      }
    } catch (e) {}
  });
</script>
