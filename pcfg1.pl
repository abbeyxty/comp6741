s(P0, s(V, NP)) --> v(P1, V), np(P2, NP), {V=v(take),P0 is P1*P2*0.35}.
s(P0, s(V, NP, PP)) --> v(P1, V), np(P2, NP), pp(P3, PP), {V=v(put),P0 is P1*P2*P3*0.65}.

np(P0, np(D, N)) --> det(P1, D), n(P2, N), {P0 is P1*P2*0.36}.
np(P0, np(D, A, N)) --> det(P1, D), a(P2, A), n(P3, N), {P0 is P1*P2*P3*0.46}.
np(P0, np(D, N, PP)) --> det(P1, D), n(P2, N), pp(P3, PP), {P0 is P1*P2*P3*0.13}.
np(P0, np(D, A, N, PP)) --> det(P1, D), a(P2, A), n(P3, N), pp(P4, PP), {P0 is P1*P2*P3*P4*0.05}.

pp(P0, pp(P, NP)) --> p(P1, P), np(P2, NP), {P0 is P1*P2*1.0, NP\=np(_,_,_,_)}.

v(0.65, v(put)) --> [put].
v(0.35, v(take)) --> [take].

n(0.23, n(block)) --> [block].
n(0.25, n(circle)) --> [circle].
n(0.15, n(cone)) --> [cone].
n(0.12, n(cube)) --> [cube].
n(0.25, n(square)) --> [square].

a(0.56, a(blue)) --> [blue].
a(0.27, a(green)) --> [green].
a(0.17, a(red)) --> [red].

det(1.0, det(the)) --> [the].

p(1.0, p(on)) --> [on].
