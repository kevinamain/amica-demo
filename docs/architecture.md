# Amica Architecture (Demo)

> This document provides a high‑level view of Amica’s design. It is **non‑sensitive** and omits production code, prompts, and API keys.

## 1) Overview
Amica is a cross‑platform emotional companion app built with **Flutter** (Dart) and a **conversational AI backend**.  
It supports **four adaptive modes** — Friend, Romantic, Mentor/Coach, Therapist — which change tone, constraints, and response style.

## 2) Goals
- Fast, safe, on‑device UI with smooth chat.
- Mode‑aware conversations that feel personal.
- Optional voice, file understanding, and lightweight memory.
- Privacy‑first: no secrets or keys stored in the client.

## 3) User Flow (high‑level)
1. User selects a **mode** and sends text/voice.
2. Client builds a **mode context** (role, tone, guardrails).
3. Request hits the **AI service** (server side).
4. AI response returns → rendered as bubbles; voice optional.
5. **Memory** stores brief, user‑approved facts to improve continuity.

## 4) System Components
- **Flutter Client (UI)**
  - Chat screen, mode selector, message composer, voice UI.
  - Local cache of recent messages; no long‑term secrets stored.
- **API Gateway / AI Service**
  - Auth, rate‑limits, logging (PII‑aware).
  - Calls the conversational model and tools (text, voice, file parse).
- **Mode Engine**
  - Maps mode → tone, guardrails, safety style, constraints.
  - Example knobs: empathy level, coaching structure, boundaries.
- **Memory (opt‑in)**
  - Short, structured facts (e.g., “prefers morning check‑ins”).
  - User can view/delete; TTL to auto‑expire.
- **Voice**
  - Client records audio → transcribe → generate reply → optional TTS.
- **File Understanding (optional)**
  - Server parses PDFs/images → summarized answer with citations.

## 5) Data Flow (simplified)
[Flutter Client]
    |  (text/voice + selected mode)
    v
[API Gateway / AI Service]
    |  (builds prompt context, calls tools)
    v
[Conversational Model] <---> [Tools: TTS/STT, File Parser, Memory]
    |
    v
[Response to Client] --> render bubbles / optional audio

## 6) Privacy & Safety
- No API keys or prompts in the client app.
- Minimal logging; PII redaction where possible.
- Memory is **explicitly user‑approved** and deletable.
- Therapist mode follows supportive, **non‑diagnostic** guidelines.

## 7) Not Included (by design)
- Production Flutter source
- Prompts, API keys, or proprietary model settings
- Internal evals, datasets, or dashboards

## 8) Roadmap (selected)
- Better session memory controls (export, wipe, per‑mode opt‑in)
- Richer tools: calendar nudges, journaling summaries
- On‑device TTS/STT fallbacks
- Safety red team prompts and automated regressions

## 9) FAQ
**Why no source code here?**  
To protect proprietary work while still demonstrating design and development quality.
