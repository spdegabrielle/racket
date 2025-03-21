#lang scribble/doc
@(require "utils.rkt" (for-label ffi/file))

@title[#:tag "file-security-guard-checks"]{File Security-Guard Checks}

@defmodule[ffi/file]

@defproc[(security-guard-check-file
           [who symbol?]
           [path path-string?]
           [perms (listof (or/c 'read 'write 'execute 'delete 'exists))])
         void?]{

Checks whether @racket[(current-security-guard)] permits access to the
file specified by @racket[path] with the permissions
@racket[perms]. See @racket[make-security-guard] for more information
on @racket[perms].

The symbol @racket[who] should be the name of the function on whose
behalf the security check is performed; it is passed to the security
guard to use in access-denied errors.
}


@defproc[(_file/guard [perms (listof (or/c 'read 'write 'execute 'delete 'exists))]
                      [who symbol? '_file/guard])
         ctype?]{

Like @racket[_file] and @racket[_path], but conversion from Racket to
C first completes the path using @racket[path->complete-path] then
cleanses it using @racket[cleanse-path], then checks that the current
security guard grants access on the resulting complete path with
@racket[perms]. As an output value, identical to @racket[_path].
}

@deftogether[[
@defthing[_file/r ctype?]
@defthing[_file/rw ctype?]]]{

Equivalent to @racket[(_file/guard '(read) '_file/r)] and
@racket[(_file/guard '(read write) '_file/rw)], respectively.}


@defproc[(security-guard-check-file-link
           [who symbol?]
           [path path-string?]
           [dest path-string?])
         void?]{

Checks whether @racket[(current-security-guard)] permits link creation
of @racket[path] as a link @racket[dest]. The symbol @racket[who] is
the same as for @racket[security-guard-check-file].

@history[#:added "6.9.0.5"]}


@defproc[(security-guard-check-network
           [who symbol?]
           [host (or/c string? #f)]
           [port (or/c (integer-in 1 65535) #f)]
           [mode (or/c 'client 'server)])
         void?]{

Checks whether @racket[(current-security-guard)] permits network
access at @racket[host] and @racket[port] in server or client
mode as specified by @racket[mode]. The symbol @racket[who] is the
same as for @racket[security-guard-check-file].

@history[#:added "6.9.0.5"]}
