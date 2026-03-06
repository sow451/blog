---
layout: page
title: Agentspotter
permalink: /agentspotter/
---

Agentspotter tracks public AI crawler and agent activity through a small public experiment.

- When an agent/crawler scrapes a recipe page,
- and the recipe page says hi and asks an agent to say "hi back",
- how often does that happen?

Data below. Note that a hi from "agent" only means there was follow-through, not a true guarantee of autonomy. More context here: <a href="/agentspotter/context/">Agentspotter Context</a>.

<div class="agentspotter-shell">
  <div id="agentspotter-status" class="agentspotter-status" aria-live="polite" hidden></div>

  <section class="agentspotter-section" id="agentspotter-counters">
    <h2>Global Counters</h2>
    <p class="agentspotter-subtext">All traffic so far. These counters are not affected by the feed filters below.</p>
    <div class="agentspotter-card-grid agentspotter-card-grid-eight">
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Scraped recipe</span>
        <span id="agentspotter-global-resource" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Called /fetch for recipe</span>
        <span id="agentspotter-global-fetch" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Said hi</span>
        <span id="agentspotter-global-hi-total" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Ratio: scraped / said hi</span>
        <span id="agentspotter-global-ratio-scraped-said-hi" class="agentspotter-card-value">0.00</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Lazy hi (GET /hi)</span>
        <span id="agentspotter-hi-get" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Serious hi (POST /hi)</span>
        <span id="agentspotter-hi-post" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">V serious hi (POST /hi + token)</span>
        <span id="agentspotter-hi-post-token" class="agentspotter-card-value">0</span>
      </article>
      <article class="agentspotter-card">
        <span class="agentspotter-card-label">Ratio: GET /hi / POST /hi</span>
        <span id="agentspotter-hi-ratio-get-post" class="agentspotter-card-value">-</span>
      </article>
    </div>
  </section>

  <section class="agentspotter-section">
    <h2>Event Feed</h2>
    <p id="agentspotter-refresh-line" class="agentspotter-refresh">Data refreshed every 10 mins. Last refreshed on -.</p>
    <div class="agentspotter-controls">
      <label class="agentspotter-control">
        <span>Type</span>
        <select id="agentspotter-filter-type">
          <option value="all">All activity</option>
          <option value="resource">Scraped recipe (read)</option>
          <option value="fetch">Called /fetch for recipe</option>
          <option value="hi_get">Lazy hi (GET /hi)</option>
          <option value="hi_post">Serious hi (POST /hi)</option>
          <option value="hi_post_token">V serious hi (POST /hi + token)</option>
        </select>
      </label>
      <label class="agentspotter-control">
        <span>Page Size</span>
        <select id="agentspotter-filter-page-size">
          <option value="25">25</option>
          <option value="50" selected>50</option>
        </select>
      </label>
      <label class="agentspotter-control">
        <span>Order</span>
        <select id="agentspotter-filter-order">
          <option value="newest" selected>Newest to Oldest</option>
          <option value="oldest">Oldest to Newest</option>
        </select>
      </label>
    </div>

    <div id="agentspotter-table-wrap" class="agentspotter-table-wrap">
      <table class="agentspotter-table">
        <thead>
          <tr>
            <th>Serial No.</th>
            <th>Route</th>
            <th>Path</th>
            <th>Date</th>
            <th>Time</th>
            <th>Name</th>
            <th>Message</th>
          </tr>
        </thead>
        <tbody id="agentspotter-table-body"></tbody>
      </table>
    </div>
    <p id="agentspotter-feed-summary" class="agentspotter-subtext">Loading matching events...</p>
  </section>
</div>

<style>
  .agentspotter-shell {
    margin-top: 24px;
    display: grid;
    gap: 24px;
  }

  .agentspotter-status {
    padding: 0.7rem 0.9rem;
    border: 1px solid var(--border-soft, #efefef);
    border-radius: 8px;
    background: var(--surface-2, #fafafa);
    color: var(--text-strong, #222);
    font-size: 0.95rem;
  }

  .agentspotter-status.is-error {
    border-color: #fecaca;
    background: #fef2f2;
    color: #991b1b;
  }

  .agentspotter-section {
    border: 1px solid var(--border-soft, #efefef);
    border-radius: 8px;
    background: var(--surface-1, #fff);
    padding: 24px;
  }

  .agentspotter-section h2 {
    margin: 0;
    font-size: 0.92rem;
    text-transform: uppercase;
    letter-spacing: 0.09em;
    color: var(--text-muted, #666);
  }

  .agentspotter-subtext {
    margin: 8px 0 16px;
    font-size: 0.92rem;
    color: var(--text-muted, #666);
  }

  .agentspotter-refresh {
    margin: 8px 0 24px;
    font-size: 0.9rem;
    color: var(--text-muted, #666);
  }

  .agentspotter-card-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
    gap: 16px;
  }

  .agentspotter-card-grid-eight {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }

  .agentspotter-card {
    border: 1px solid var(--border-soft, #efefef);
    border-radius: 8px;
    padding: 20px 24px;
    background: var(--surface-2, #fafafa);
    min-height: 108px;
  }

  .agentspotter-card-label {
    display: block;
    margin-bottom: 8px;
    font-size: 12.5px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    color: #666b73;
    font-weight: 500;
  }

  .agentspotter-card-value {
    display: block;
    font-size: clamp(36px, 4vw, 40px);
    font-weight: 600;
    color: var(--text-strong, #222);
    line-height: 1;
  }

  .agentspotter-controls {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
    gap: 16px;
    align-items: end;
  }

  .agentspotter-control {
    display: grid;
    gap: 16px;
    font-size: 0.88rem;
    color: var(--text-strong, #222);
  }

  .agentspotter-control span {
    font-size: 13px;
    color: #636972;
    font-weight: 500;
    letter-spacing: 0.01em;
  }

  .agentspotter-control select {
    width: 100%;
    height: 44px;
    border: 1px solid var(--border-soft, #dfdfdf);
    border-radius: 8px;
    background: #fff;
    color: #222;
    font-size: 0.95rem;
    padding: 0 12px;
  }

  .agentspotter-table-wrap {
    border: 1px solid #e5e8ee;
    border-radius: 8px;
    overflow-x: auto;
    background: var(--surface-1, #fff);
    margin-top: 24px;
  }

  .agentspotter-table {
    width: 100%;
    border-collapse: collapse;
    margin: 0;
    min-width: 760px;
  }

  .agentspotter-table th,
  .agentspotter-table td {
    border: none;
    border-bottom: 1px solid #eceef2;
    padding: 14px 16px;
    vertical-align: top;
    font-size: 0.9rem;
    text-align: left;
  }

  .agentspotter-table th {
    background: #f6f8fb;
    color: var(--text-strong, #222);
    font-weight: 600;
  }

  .agentspotter-table tbody tr:nth-child(even) td {
    background: #fcfdff;
  }

  .agentspotter-table tr:last-child td {
    border-bottom: none;
  }

  @media (max-width: 980px) {
    .agentspotter-card-grid-eight {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }

  @media (max-width: 620px) {
    .agentspotter-card-grid-eight {
      grid-template-columns: 1fr;
    }
  }
</style>

<script>
  (function () {
    var API_URL = "https://agentspotter-backend-production.up.railway.app/events/public?type=all&source=all&hide_likely_crawlers=true&limit=50";
    var statusEl = document.getElementById("agentspotter-status");
    var tableBodyEl = document.getElementById("agentspotter-table-body");
    var feedSummaryEl = document.getElementById("agentspotter-feed-summary");
    var refreshLineEl = document.getElementById("agentspotter-refresh-line");
    var typeFilterEl = document.getElementById("agentspotter-filter-type");
    var pageSizeEl = document.getElementById("agentspotter-filter-page-size");
    var orderEl = document.getElementById("agentspotter-filter-order");

    var globalResourceEl = document.getElementById("agentspotter-global-resource");
    var globalFetchEl = document.getElementById("agentspotter-global-fetch");
    var globalHiTotalEl = document.getElementById("agentspotter-global-hi-total");
    var globalRatioScrapedSaidHiEl = document.getElementById("agentspotter-global-ratio-scraped-said-hi");

    var hiGetEl = document.getElementById("agentspotter-hi-get");
    var hiPostEl = document.getElementById("agentspotter-hi-post");
    var hiPostTokenEl = document.getElementById("agentspotter-hi-post-token");
    var hiRatioGetPostEl = document.getElementById("agentspotter-hi-ratio-get-post");

    var numberFormat = new Intl.NumberFormat("en-US");
    var state = {
      events: [],
      counters: {},
      refresh: {}
    };

    function pickFirst(object, keys) {
      if (!object || typeof object !== "object") return null;
      for (var i = 0; i < keys.length; i += 1) {
        var value = object[keys[i]];
        if (value !== undefined && value !== null && value !== "") return value;
      }
      return null;
    }

    function toNumber(value, fallback) {
      var parsed = Number(value);
      return Number.isFinite(parsed) ? parsed : fallback;
    }

    function setStatus(text, isError) {
      var hasText = Boolean(text && String(text).trim());
      statusEl.hidden = !hasText;
      if (!hasText) {
        statusEl.textContent = "";
        statusEl.classList.remove("is-error");
        return;
      }
      statusEl.textContent = text;
      statusEl.classList.toggle("is-error", Boolean(isError));
    }

    function normalizeEvents(payload) {
      if (!payload || typeof payload !== "object") return [];
      if (Array.isArray(payload.events)) return payload.events;
      if (Array.isArray(payload.items)) return payload.items;
      if (Array.isArray(payload.results)) return payload.results;
      return [];
    }

    function normalizeCounters(payload) {
      var counters = payload && typeof payload === "object" && payload.counters && typeof payload.counters === "object"
        ? payload.counters
        : {};

      var hiGet = toNumber(counters.hi_get, 0);
      var hiPost = toNumber(counters.hi_post, 0);
      var hiPostToken = toNumber(counters.hi_post_token, 0);
      var hiTotal = toNumber(counters.hi_total, hiGet + hiPost + hiPostToken);
      var resource = toNumber(counters.resource, 0);
      var fetch = toNumber(counters.fetch, 0);

      return {
        resource: resource,
        fetch: fetch,
        hi_get: hiGet,
        hi_post: hiPost,
        hi_post_token: hiPostToken,
        hi_total: hiTotal
      };
    }

    function signalKey(event) {
      var eventType = pickFirst(event, ["event_type", "type", "kind"]);
      var tokenUsed = Boolean(event && event.token_used);
      if (eventType === "hi_post" && tokenUsed) return "hi_post_token";
      if (eventType === "hi_post") return "hi_post";
      if (eventType === "hi_get") return "hi_get";
      if (eventType === "fetch") return "fetch";
      if (eventType === "resource") return "resource";
      return "unknown";
    }

    function routeLabel(event) {
      var key = signalKey(event);
      if (key === "fetch") return "GET /agent.txt";
      if (key === "resource") return "GET " + (pickFirst(event, ["path"]) || "-");
      if (key === "hi_get") return "GET /hi";
      if (key === "hi_post") return "POST /hi";
      if (key === "hi_post_token") return "POST /hi + token";
      return (pickFirst(event, ["event_type", "type"]) || "-").toString();
    }

    function displayName(event) {
      var source = pickFirst(event, ["source_kind", "source"]);
      if (!source || source === "unknown" || source === "none") return "anonymous";
      return String(source);
    }

    function displayMessage(event) {
      var key = signalKey(event);
      if (key === "hi_get" || key === "hi_post" || key === "hi_post_token") return "hi";
      return "-";
    }

    function eventTimestamp(event) {
      return pickFirst(event, ["ts", "timestamp", "created_at", "createdAt"]);
    }

    function formatUtcTimestamp(value) {
      if (!value) return "-";
      var date = new Date(value);
      if (Number.isNaN(date.getTime())) return String(value);
      function pad(num) {
        return String(num).padStart(2, "0");
      }
      return (
        date.getUTCFullYear() +
        "-" + pad(date.getUTCMonth() + 1) +
        "-" + pad(date.getUTCDate()) +
        " " + pad(date.getUTCHours()) +
        ":" + pad(date.getUTCMinutes()) +
        ":" + pad(date.getUTCSeconds()) +
        " UTC"
      );
    }

    function formatLocalTimestamp(value) {
      if (!value) return "-";
      var date = new Date(value);
      if (Number.isNaN(date.getTime())) return String(value);
      var months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];
      function pad(num) {
        return String(num).padStart(2, "0");
      }
      return (
        date.getDate() +
        " " + months[date.getMonth()] +
        ", " + date.getFullYear() +
        " at " + pad(date.getHours()) +
        ":" + pad(date.getMinutes()) +
        ":" + pad(date.getSeconds())
      );
    }

    function formatLocalDatePart(value) {
      if (!value) return "-";
      var date = new Date(value);
      if (Number.isNaN(date.getTime())) return String(value);
      var months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];
      return date.getDate() + " " + months[date.getMonth()] + ", " + date.getFullYear();
    }

    function formatLocalTimePart(value) {
      if (!value) return "-";
      var date = new Date(value);
      if (Number.isNaN(date.getTime())) return String(value);
      function pad(num) {
        return String(num).padStart(2, "0");
      }
      return pad(date.getHours()) + ":" + pad(date.getMinutes()) + ":" + pad(date.getSeconds());
    }

    function formatRatio(value) {
      return Number.isFinite(value) ? value.toFixed(2) : "-";
    }

    function clearChildren(node) {
      while (node.firstChild) node.removeChild(node.firstChild);
    }

    function renderCards(counters) {
      globalResourceEl.textContent = numberFormat.format(counters.resource);
      globalFetchEl.textContent = numberFormat.format(counters.fetch);
      globalHiTotalEl.textContent = numberFormat.format(counters.hi_total);
      globalRatioScrapedSaidHiEl.textContent = formatRatio(counters.hi_total > 0 ? counters.resource / counters.hi_total : 0);

      hiGetEl.textContent = numberFormat.format(counters.hi_get);
      hiPostEl.textContent = numberFormat.format(counters.hi_post);
      hiPostTokenEl.textContent = numberFormat.format(counters.hi_post_token);
      hiRatioGetPostEl.textContent = counters.hi_post > 0 ? formatRatio(counters.hi_get / counters.hi_post) : "-";
    }

    function applyFilters(events) {
      var selectedType = typeFilterEl.value;
      var selectedOrder = orderEl.value;
      var selectedPageSize = toNumber(pageSizeEl.value, 50);

      var filtered = events.filter(function (event) {
        if (selectedType === "all") return true;
        return signalKey(event) === selectedType;
      });

      filtered.sort(function (a, b) {
        var aTs = new Date(eventTimestamp(a) || 0).getTime();
        var bTs = new Date(eventTimestamp(b) || 0).getTime();
        var safeATs = Number.isFinite(aTs) ? aTs : 0;
        var safeBTs = Number.isFinite(bTs) ? bTs : 0;
        return selectedOrder === "oldest" ? safeATs - safeBTs : safeBTs - safeATs;
      });

      return filtered.slice(0, selectedPageSize);
    }

    function renderTable(events) {
      clearChildren(tableBodyEl);

      if (!events.length) {
        feedSummaryEl.textContent = "Loaded 0 matching events.";
        return;
      }

      events.forEach(function (event, index) {
        var row = document.createElement("tr");

        var serialCell = document.createElement("td");
        serialCell.textContent = String(index + 1);
        row.appendChild(serialCell);

        var routeCell = document.createElement("td");
        routeCell.textContent = routeLabel(event);
        row.appendChild(routeCell);

        var pathCell = document.createElement("td");
        pathCell.textContent = String(pickFirst(event, ["path"]) || "-");
        row.appendChild(pathCell);

        var dateCell = document.createElement("td");
        dateCell.textContent = formatLocalDatePart(eventTimestamp(event));
        row.appendChild(dateCell);

        var timeCell = document.createElement("td");
        timeCell.textContent = formatLocalTimePart(eventTimestamp(event));
        row.appendChild(timeCell);

        var nameCell = document.createElement("td");
        nameCell.textContent = displayName(event);
        row.appendChild(nameCell);

        var messageCell = document.createElement("td");
        messageCell.textContent = displayMessage(event);
        row.appendChild(messageCell);

        tableBodyEl.appendChild(row);
      });

      feedSummaryEl.textContent = "Loaded " + numberFormat.format(events.length) + " matching events.";
    }

    function renderRefreshLine(refresh) {
      var cadenceMinutes = toNumber(refresh.cadence_minutes, 10);
      var refreshedAt = formatLocalTimestamp(refresh.last_refreshed_at);
      refreshLineEl.textContent = "Data refreshed every " + cadenceMinutes + " mins. Last refreshed on " + refreshedAt + ".";
    }

    function renderFeed() {
      var filteredEvents = applyFilters(state.events);
      renderTable(filteredEvents);
    }

    function bindControls() {
      [typeFilterEl, pageSizeEl, orderEl].forEach(function (element) {
        element.addEventListener("change", renderFeed);
      });
    }

    async function loadFeed() {
      setStatus("", false);

      try {
        var response = await fetch(API_URL, {
          method: "GET",
          headers: { Accept: "application/json" },
          cache: "no-store"
        });

        if (!response.ok) {
          throw new Error("Request failed (" + response.status + ")");
        }

        var payload = await response.json();
        state.events = normalizeEvents(payload);
        state.counters = normalizeCounters(payload);
        state.refresh = payload && typeof payload === "object" && payload.refresh && typeof payload.refresh === "object"
          ? payload.refresh
          : {};

        renderCards(state.counters);
        renderRefreshLine(state.refresh);
        renderFeed();

        setStatus("", false);
      } catch (error) {
        feedSummaryEl.textContent = "Loaded 0 matching events.";
        refreshLineEl.textContent = "Data refreshed every 10 mins. Last refreshed on -.";
        setStatus("Could not load the public feed right now. Please try again shortly.", true);
      }
    }

    bindControls();
    loadFeed();
  })();
</script>
