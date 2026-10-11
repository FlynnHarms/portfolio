# portfolio

Personal engineering portfolio for Flynn Harms (Electrical Engineering, CSU Long Beach).
Plain HTML/CSS, no build step, hosted with GitHub Pages.

## Layout

```
index.html                     home page: intro, project cards, skills, contact
assets/style.css               shared styles (light + dark mode)
assets/resume.pdf              your resume (add this)
projects/<name>/index.html     one page per project
projects/<name>/img/           screenshots, diagrams, board photos
projects/<name>/src/           source files (VHDL, XDC, C, MATLAB, ...)
```

## Publish it

1. Merge this branch into `main`.
2. On GitHub: **Settings → Pages → Build and deployment → Deploy from a branch**, pick `main` and `/ (root)`.
3. The site appears at `https://flynnharms.github.io/portfolio/` after a minute or two. Put that link on your resume and LinkedIn.

To preview locally: `python3 -m http.server` in this folder, then open http://localhost:8000.

## Before sharing, fill in the TODOs

Search for `TODO` in the HTML:

- `assets/resume.pdf`: add your resume
- LinkedIn URL and contact email in `index.html`
- A photo or short video of the Basys 3 running the lock (`projects/digital-lock/img/board.jpg`)

## Adding a project with Claude Code

Upload your lab report, code and screenshots, then ask something like:

> Add a new project page for my lab report (attached), modeled on projects/digital-lock.
> Pull the source code into src/, the useful figures into img/, and add a card to index.html.

Good inputs: the report (.docx/.pdf), the source files themselves (not screenshots of code),
simulation waveforms, schematics, and photos of the hardware working.
