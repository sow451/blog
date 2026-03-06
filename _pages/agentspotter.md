---
layout: page
title: Agentspotter
permalink: /agentspotter/
---

Agentspotter tracks public AI crawler and agent activity through a small public experiment.

- When an agent/crawler scrapes a recipe page,
- and the recipe page says hi and asks an agent to say "hi back",
- how often does that happen?

Data below. Please note: A successful hi from "agent" only means there was follow-through, it is not a true guarantee of autonomy.

For full method and context, see <a href="/agentspotter/context/">Agentspotter Context</a>.

<div class="agentspotter-shell">
  <div id="agentspotter-status" class="agentspotter-status" aria-live="polite">Loading latest public events...</div>
  <p class="agentspotter-refresh">Last refreshed: <span id="agentspotter-refreshed">-</span></p>

  <div id="agentspotter-counters" class="agentspotter-counters" hidden></div>

  <div id="agentspotter-table-wrap" class="agentspotter-table-wrap" hidden>
    <table class="agentspotter-table">
      <thead>
        <tr>
          <th>Time</th>
          <th>Type</th>
          <th>Source</th>
          <th>Event</th>
          <th>Target</th>
        </tr>
      </thead>
      <tbody id="agentspotter-table-body"></tbody>
    </table>
  </div>
</div>

<style>
  .agentspotter-shell {
    margin-top: 1rem;
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

  .agentspotter-refresh {
    margin: 0.75rem 0 1rem;
    font-size: 0.9rem;
    color: var(--text-muted, #666);
  }

  .agentspotter-counters {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap: 0.75rem;
    margin: 1rem 0 1.2rem;
  }

  .agentspotter-counter {
    border: 1px solid var(--border-soft, #efefef);
    border-radius: 8px;
    padding: 0.75rem 0.9rem;
    background: var(--surface-1, #fff);
  }

  .agentspotter-counter-label {
    display: block;
    margin-bottom: 0.2rem;
    font-size: 0.8rem;
    color: var(--text-muted, #666);
    text-transform: uppercase;
    letter-spacing: 0.04em;
  }

  .agentspotter-counter-value {
    font-size: 1.35rem;
    font-weight: 600;
    line-height: 1.2;
    color: var(--text-strong, #222);
  }

  .agentspotter-counter-note {
    margin-left: 0.35rem;
    font-size: 0.75rem;
    color: var(--text-muted, #666);
    font-weight: 400;
  }

  .agentspotter-table-wrap {
    border: 1px solid var(--border-soft, #efefef);
    border-radius: 8px;
    overflow-x: auto;
    background: var(--surface-1, #fff);
  }

  .agentspotter-table {
    width: 100%;
    border-collapse: collapse;
    margin: 0;
    min-width: 700px;
  }

  .agentspotter-table th,
  .agentspotter-table td {
    border: none;
    border-bottom: 1px solid var(--border-soft, #efefef);
    padding: 0.62rem 0.75rem;
    vertical-align: top;
    font-size: 0.9rem;
    text-align: left;
  }

  .agentspotter-table th {
    background: var(--surface-2, #fafafa);
    color: var(--text-strong, #222);
    font-weight: 600;
  }

  .agentspotter-table tr:last-child td {
    border-bottom: none;
  }

  .agentspotter-target {
    white-space: nowrap;
  }
</style>

<script>
  (function () {
    var API_URL = "https://agentspotter-backend-production.up.railway.app/events/public?type=all&source=all&hide_likely_crawlers=true&limit=25";
    var statusEl = document.getElementById("agentspotter-status");
    var refreshedEl = document.getElementById("agentspotter-refreshed");
    var countersEl = document.getElementById("agentspotter-counters");
    var tableWrapEl = document.getElementById("agentspotter-table-wrap");
    var tableBodyEl = document.getElementById("agentspotter-table-body");
    var numberFormat = new Intl.NumberFormat("en-US");
    var dateTimeFormat = new Intl.DateTimeFormat("en-US", { dateStyle: "medium", timeStyle: "short" });

    function pickFirst(object, keys) {
      if (!object || typeof object !== "object") return null;
      for (var i = 0; i < keys.length; i += 1) {
        var value = object[keys[i]];
        if (value !== undefined && value !== null && value !== "") return value;
      }
      return null;
    }

    function normalizeEvents(payload) {
      if (Array.isArray(payload)) return payload;
      if (!payload || typeof payload !== "object") return [];
      if (Array.isArray(payload.events)) return payload.events;
      if (Array.isArray(payload.items)) return payload.items;
      if (Array.isArray(payload.results)) return payload.results;
      if (payload.data) {
        if (Array.isArray(payload.data)) return payload.data;
        if (Array.isArray(payload.data.events)) return payload.data.events;
        if (Array.isArray(payload.data.items)) return payload.data.items;
      }
      return [];
    }

    function formatDateTime(value) {
      if (!value) return "-";
      var asDate = value instanceof Date ? value : new Date(value);
      if (Number.isNaN(asDate.getTime())) return String(value);
      return dateTimeFormat.format(asDate);
    }

    function setStatus(text, isError) {
      statusEl.textContent = text;
      statusEl.classList.toggle("is-error", Boolean(isError));
    }

    function setRefreshedTime(value) {
      refreshedEl.textContent = formatDateTime(value);
    }

    function eventSource(event) {
      return pickFirst(event, ["source_kind", "source", "source_type", "channel", "origin"]) || "unknown";
    }

    function eventType(event) {
      return pickFirst(event, ["event_type", "type", "kind", "category"]) || "unknown";
    }

    function eventTime(event) {
      return pickFirst(event, ["ts", "occurred_at", "occurredAt", "timestamp", "created_at", "createdAt", "event_time", "time"]);
    }

    function eventSummary(event) {
      return pickFirst(event, ["title", "event", "message", "summary", "description", "path", "url", "target", "target_url"]) || "-";
    }

    function eventTargetUrl(event) {
      return pickFirst(event, ["target_url", "targetUrl", "url", "page_url", "pageUrl", "href"]);
    }

    function eventTargetLabel(event, targetUrl) {
      return pickFirst(event, ["target", "path", "resource", "hostname"]) || targetUrl || "-";
    }

    function uniqueCount(values) {
      var cleanValues = values.filter(function (item) {
        return item !== null && item !== undefined && item !== "";
      });
      return new Set(cleanValues).size;
    }

    function clearChildren(node) {
      while (node.firstChild) node.removeChild(node.firstChild);
    }

    function renderCounters(events, payload) {
      clearChildren(countersEl);
      var serverTotal = Number(pickFirst(payload, ["total", "count", "total_events", "totalEvents"]));
      var cards = [
        {
          label: "Events shown",
          value: numberFormat.format(events.length),
          note: !Number.isNaN(serverTotal) && serverTotal > events.length ? "of " + numberFormat.format(serverTotal) : ""
        },
        { label: "Unique sources", value: numberFormat.format(uniqueCount(events.map(eventSource))) },
        { label: "Unique event types", value: numberFormat.format(uniqueCount(events.map(eventType))) }
      ];

      cards.forEach(function (card) {
        var wrapper = document.createElement("div");
        wrapper.className = "agentspotter-counter";

        var label = document.createElement("span");
        label.className = "agentspotter-counter-label";
        label.textContent = card.label;

        var value = document.createElement("span");
        value.className = "agentspotter-counter-value";
        value.textContent = card.value;

        if (card.note) {
          var note = document.createElement("span");
          note.className = "agentspotter-counter-note";
          note.textContent = card.note;
          value.appendChild(note);
        }

        wrapper.appendChild(label);
        wrapper.appendChild(value);
        countersEl.appendChild(wrapper);
      });

      countersEl.hidden = false;
    }

    function renderRows(events) {
      clearChildren(tableBodyEl);

      events.forEach(function (event) {
        var row = document.createElement("tr");

        var timeCell = document.createElement("td");
        timeCell.textContent = formatDateTime(eventTime(event));
        row.appendChild(timeCell);

        var typeCell = document.createElement("td");
        typeCell.textContent = String(eventType(event));
        row.appendChild(typeCell);

        var sourceCell = document.createElement("td");
        sourceCell.textContent = String(eventSource(event));
        row.appendChild(sourceCell);

        var summaryCell = document.createElement("td");
        summaryCell.textContent = String(eventSummary(event));
        row.appendChild(summaryCell);

        var targetCell = document.createElement("td");
        targetCell.className = "agentspotter-target";
        var targetUrl = eventTargetUrl(event);
        if (targetUrl) {
          var link = document.createElement("a");
          link.href = String(targetUrl);
          link.textContent = String(eventTargetLabel(event, targetUrl));
          link.target = "_blank";
          link.rel = "noopener";
          targetCell.appendChild(link);
        } else {
          targetCell.textContent = String(eventTargetLabel(event, targetUrl));
        }
        row.appendChild(targetCell);

        tableBodyEl.appendChild(row);
      });

      tableWrapEl.hidden = events.length === 0;
    }

    async function loadFeed() {
      setStatus("Loading latest public events...", false);

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
        var events = normalizeEvents(payload);

        renderCounters(events, payload);
        renderRows(events);
        setRefreshedTime(new Date());

        if (events.length) {
          setStatus("Showing latest public activity.", false);
        } else {
          setStatus("No public events are available right now.", false);
        }
      } catch (error) {
        countersEl.hidden = true;
        tableWrapEl.hidden = true;
        setRefreshedTime(new Date());
        setStatus("Could not load the public feed right now. Please try again shortly.", true);
      }
    }

    loadFeed();
  })();
</script>
