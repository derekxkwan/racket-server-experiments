# racket-server-experiments

mainly a personal-use repo for learning how to create stuff with racket's web-server library, want to eventually integrate websockets into here...


but if you really want to try to see what i'm messing around with, run `racket main.rkt` and send it random commands such as:
- `curl http://localhost:8000/`
- `curl http://localhost:8000/ -d name=kitty -d color=black`
- `curl http://localhost:8000/cat/pet`
- `curl http://localhost:8000/cat/throw/mouse`
- `curl http://localhost:8000/thisisnonsenseandwillroutetotheelseclause`
