# containerdev

These are some shell functions that I have cobbled together for doing sane
development while using a container to run the result. They are simple, but
meant to be reusable among different various projects.

To use them, `source containerdev.sh`, and add `.containerdev` to your global
`.gitignore` file.

### What currently works

#### `containerdev-start`

This will start a new containerdev project in the current directory by creating
the directory `.containerdev` and populating it with a `Dockerfile` template.

I recommend your containerdev `Dockerfile` has `vim` and `git` for editing and
committing from within the development environment, but it's not strictly
necessary if you just wish to *run* the project in containerdev.

#### `containerdev-build`

This will build the `Dockerfile` you create, using `podman`.

#### `containerdev`

This will run your image, mounting the current directory under `/project`, and
(depending on your `Dockerfile`) it will likely drop you to a shell in
`/project`.

You can create the file `.containerdev/runargs` with extra arguments that get
passed to `podman run`. This is useful for things like forwarding ports,
mounting extra volumes, etc.


### NOTE

You can rename `.containerdev` to `.containerdev-public` if you wish to share
it as part of your actual project. If both directories exist, `.containerdev`
takes precedence (useful for e.g. overriding default containerdev setups for
personal use).
