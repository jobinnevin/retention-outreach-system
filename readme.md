# Customer Retention and Automated Outreach System

An end-to-end BSA project simulating a retention risk system for a Canadian P&C insurer. Combines SQL-based data cleaning and risk scoring, a Power BI dashboard, and an AI-drafted, human-approved outreach workflow.

## What it does
- Cleans and validates a 50,000-record policyholder book using a medallion architecture (bronze → silver → gold) in PostgreSQL
- Scores every policyholder for lapse risk using transparent, rule-based logic, validated against 15,000 historical renewals (**4.4x** higher lapse rate in High vs Low tier)
- Surfaces risk tiers and premium exposure on a Power BI dashboard (**$13.73M** in premium at risk, **$3.33M** renewing within 90 days)
- Drafts personalized, bilingual outreach messages for high-risk customers via the Claude API, routed through Power Automate
- Requires human approval before any message is sent, no automated outreach goes out unreviewed

## Tech stack
PostgreSQL · Power BI · Power Automate Desktop · Claude API (Anthropic) · Python (data generation)

## Repo structure
- `sql/` — cleaning and scoring scripts
- `data/` — sample dataset, data dictionary, and the generator script
- `docs/` — business requirements, functional/non-functional requirements, user stories
- `dashboard/` — dashboard screenshot and demo GIF
- `automation/` — Power Automate flow and sample outreach output

## Notes
Dataset is synthetic and self-generated, designed with realistic churn drivers so the scoring rules could be validated against known outcomes. All company names are fictional.

**Author:** Joseph Nevin (Jobin) — Business Systems Analyst, ECBA
