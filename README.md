# RaceDay-POE
RaceDay – a database and API design for an event management platform where Organisers create running/walking/cycling events and Participants enrol and view results. Includes ERD, API endpoint plan, and SQL Server schema.

System Description

RaceDay is an event management platform for running, walking, and cycling events. Organisers can create events, define the race categories on offer for each event (e.g. 10km, 21km), and attach route/map files to those categories. Participants can browse upcoming events, enrol into a specific category, and view their own results once an Organiser captures them after the race.

The system is modelled around seven core entities: Organiser, Participant, Event, Category, Route, Enrolment, and Result. Organiser and Participant are kept as separate tables (rather than a single Users table with a Role column), so a person's role is determined by which table their account lives in — this is reflected directly in the API's split registration endpoints and role-aware login.

This repository contains the planning artefacts for the project:

Entity Relationship Diagram (ERD) — /docs/ERD.png
API Endpoint Plan — /docs/Endpoint-Plan.pdf
SQL Database Script — /docs/RaceDayDB.sql
