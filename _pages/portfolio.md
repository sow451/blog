---
layout: page
title: Portfolio
permalink: /portfolio/
projects:
  - title: "Gold Loan Renewal Agentic Workflow"
    year: "2026"
    status: "WIP"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Pettai Rap Basket of Goods v CPI Basket of Goods"
    year: "2026"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "FLDG"
    year: "2025/2026"
    status: "WIP"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Migration Enabler v1"
    year: "2025"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Overheard At"
    year: "2025"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Gold-loan LOS"
    year: "2025"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Gold Loan LMS"
    year: "2025"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "DA Software"
    year: "2025"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Private Debt Funds"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Dictation Potato"
    year: "2024"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Backpack go"
    year: "2024"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Stepsu"
    year: "2024"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "A DB of the RBI's monthly credit data"
    year: "2024"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Merchant ACH Recon"
    year: "2022"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Pay w Rewards"
    year: "2022"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Swifter"
    year: "2021"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "GIGI"
    year: "2019"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Impact on Metro Construction on Traffic in Blore"
    year: "2018"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "Chrome Extension"
    year: "2017"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  - title: "What Happened in Parliament Today"
    year: "2015"
    note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
---

This portfolio is a selection of projects I've built, reflecting my work with AI tools, credit and payments (SaaS and B2C).  


<div class="portfolio-controls">
  {% include view-toggle.html label="Portfolio view toggle" %}
</div>

<div class="view-panel view-cards is-active">
  <div class="project-grid">
    {% for project in page.projects %}
      {% include project-card.html project=project id=forloop.index %}
    {% endfor %}
  </div>
</div>

<div class="view-panel view-list">
  <div class="project-list-simple">
    {% for project in page.projects %}
      {% include project-row.html project=project id=forloop.index %}
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

    var infoToggles = document.querySelectorAll('.project-card .project-info-toggle');
    var projectCards = document.querySelectorAll('.project-card');

    function closeAllProjectDetails() {
      projectCards.forEach(function (card) {
        card.classList.remove('is-open');
        var toggle = card.querySelector('.project-info-toggle');
        if (toggle) toggle.setAttribute('aria-expanded', 'false');
      });
    }

    infoToggles.forEach(function (toggle) {
      toggle.addEventListener('click', function (event) {
        event.stopPropagation();
        var card = toggle.closest('.project-card');
        if (!card) return;
        var isOpen = card.classList.contains('is-open');
        closeAllProjectDetails();
        if (isOpen) return;
        card.classList.add('is-open');
        toggle.setAttribute('aria-expanded', 'true');
      });
    });
  });
</script>
