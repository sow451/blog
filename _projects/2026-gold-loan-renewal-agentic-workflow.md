---
layout: project
title: "Gold Loan (IBT)-  Renewal via Agentic Workflow"
preview: "https://ibtagenticdemo.streamlit.app/"
year: "2026"
note: "A high ROI agentic workflow to increase renewal rates for IBT gold loans."
image: "/images/projects/2026-gold-loan-renewal-agentic-workflow.md/thumbnail.png"

---


## Gold Loans in India

Gold loans are a thriving business in India, especially given the recent (2025-2026) gold price market rally. The industry of gold loans in India has seen high CAGR (20% for banks, 35+% for NBFCs). 

FYI: I spent most of 2025 building credit infrastructure and underwriting tools for the gold loan industry.

## Opportunity Noticed

While reviewing my client's loan books and getting to know their operational challenges, I came across the "rough estimate" of renewal loans being close to 60% of a typical NBFC's portfolio. What this means is that 60% of the client's loan book would be made up of renewals - internal and external.

Customers who avail gold loans can either take up an IBT (internal balance transfer) or an EBT (external balance transfer - where they move their loans from one NBFC to another.) I do not have the exact IBT/EBT split of this 60%.

## Hypothesis
NBFCs win if they can retain customers who would otherwise take up EBT at a competitor. 

In a rising gold price environment, every customer sitting on "appreciated" collateral is a live EBT target: a competitor can revalue their gold at today's price, lend a larger amount against it, use part of that to close the existing loan, and hand the customer the difference as cash. 

Today, this process of identifying at-risk customers and executing renewals is either manual or doesn't happen at all, leading to revenue leakage. Proactive IBT flips this from reactive to preemptive. 


## Agentic Solution: Proactive IBT 

An agentic workflow that:
-  Identifies, prioritizes, and converts gold loan customers who are at risk of leaving to a competitor via EBT. 
- Is measured against the 'North Star Metric': No. of customers lost to EBT(tracked MoM).

## Business Case

In our example: A fictious 8,000-customer book holds ₹245 Cr in collateral against ₹143 Cr in outstanding loans - ₹37 Cr of trapped equity that the company is not lending against but a competitor will. 

**(this data/ loan book estimates are all made up and not real)**


![EBT threat and attrition model](/images/projects/2026-gold-loan-renewal-agentic-workflow.md/EBT%20Threat%20quantified.png)


As you can see - the EBT attrition threat is real for our fictious NBFC. 

Industry data shows 30–40% of gold loan customers don't renew at maturity, and we estimate 20–30% of our book is specifically exposed to EBT: customers who still want a loan but will take it from whoever offers more money against the same gold. Further, a loss of renewal also impacts the CAC: LTV metric, increasing win-back and performance ad spend costs. 


![NII and P&L impact scenario](/images/projects/2026-gold-loan-renewal-agentic-workflow.md/NII%20and%20P%26L%20Impact.png)


P&L Impact: At an 80% recovery rate on EBT-exposed customers, Proactive IBT delivers **₹4.9 Cr in incremental annual income on a approx ₹25L build** — a payback period under one month. 

Proactive IBT in this case also moves from being a product-led growth initiative; to a customer retention and portfolio defence mechanism, with the added upside of generating significant revenue, alongside a projected **increase in renewal rate from 40 - 60% (industry standard) to 75%+**.


## Proposed Agentic Workflow

![Proactive IBT orchestrator and agent interactions](/images/projects/2026-gold-loan-renewal-agentic-workflow.md/agentic_orchestrator_interactions.png)


In the demo, I built the workflow to be simple, and intentionally deterministic: one customer goes through fixed stages (rate fetch, scan, scoring, KYC, offer, communication, OTP, closure), with simulated outcomes and clear step-by-step logs. This gives us an idea of how we can run the pipeline and understand edge cases and errors better. We are trading-off reliability, speed, and explainability for a live walkthrough made in record time (less than a day).

In production, the same flow should be upgraded to a true orchestrated agentic system with MCP / API handling capabilities. The orchestrator will manage state transitions, error handling, retries, callback scheduling, and automatic re-runs when external dependencies fail or customer responses are delayed. 

Instead of fixed-path execution and manually mapping all possible route, production logic s support dynamic routing, RAG-drivenpolicy decisions, and "send for approval" flows and graceful recovery, so the pipeline can run continuously at portfolio scale with minimal manual intervention. 

There is some observability built in, but nowhere close to the level needed for even a CUG/internal beta. No evals have been set, and the flow is process-wise audit-ready only where it is deterministic and not model-led. 

![Video walkthrough screenshot](/images/projects/2026-gold-loan-renewal-agentic-workflow.md/voice%20recordings.png)

Eleven Labs was used to record an example call - this has no "actual benefit" to the demo, since its simulated and one-sided, but I enjoyed translating my thoughts into Hindi and finding an appropriate voice for this purpose - used it as an opportunity to play around w Vapi, and ultimately went with Eleven for speed and ease for a few mins.

