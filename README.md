
# Insurance Customer Retention and Automated Outreach System (Canadian P&C Insurer)

This project simulates a retention risk system for a Canadian insurance company. Customer data is cleaned and scored using SQL in PostgreSQL, shown in a Power BI dashboard, and used to draft personalized outreach messages through the Claude API, automated with Power Automate and reviewed by a person before anything gets sent.

## What it does
- Cleans and scores 50,000 policyholder records using SQL in PostgreSQL
- Validates the scoring rules against 15,000 historical renewals (4.4x higher lapse rate in high-risk vs low-risk)
- Surfaces risk and premium exposure on a Power BI dashboard
- Drafts personalized, bilingual outreach messages via the Claude API
- Routes every draft through Power Automate for human approval before sending

## Retention Risk Dashboard

<img width="986" height="548" alt="Retention_dashboard_gif-ezgif com-optimize" src="https://github.com/user-attachments/assets/3ddbb9a1-6197-4b0c-b494-508ce94921bc" />

## Automated outreach in action

<img width="1080" height="608" alt="demo-automate" src="https://github.com/user-attachments/assets/d77db962-db5c-4d84-a414-88a5ef3d03ea" />

**Customers going in:**
![Outreach queue](automation/outreach_queue.png)

**Drafts coming out, awaiting approval:**
<img width="1911" height="1075" alt="outreach_message " src="https://github.com/user-attachments/assets/17bc61be-5aa8-459d-a874-5f07c2ba5e76" />


## Built with
PostgreSQL · Python · SQL · Power BI · Power Automate · Claude API

## Repo structure
- `sql/` — cleaning and scoring scripts
- `data/` — sample data, dictionary, and generator script
- `docs/` — business requirements, functional and non-functional requirements, user stories
- `dashboard/` — dashboard demo
- `automation/` — outreach flow demo

Data is synthetic and self-generated. Company name is fictional.

**Joseph Nevin (Jobin)** — Business Systems Analyst, ECBA
