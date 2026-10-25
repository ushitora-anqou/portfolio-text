#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, appendix-count, term-meta

#appendix-count.update(1)

#heading(numbering: none)[付録A　第2章の補題と定理の証明]

この付録では、第 2 章で述べた補題、定理、系の主張を再掲し、その証明を章の順に与える。

#heading(level: 2, numbering: none)[A.1　和の記号]

@lem-sum-linear（和の線形性）。$c, d$ を実数とするとき、任意の $n$ に対して
$ sum_(i=1)^n (c a_i + d b_i) = c sum_(i=1)^n a_i + d sum_(i=1)^n b_i $
が成り立つ。
#proof[
  $n = 1$ のとき、両辺とも $c a_1 + d b_1$ であり等しい。$n = k$ で等しいと仮定する。このとき
  $ sum_(i=1)^(k+1) (c a_i + d b_i) &= (c a_1 + d b_1) + ... + (c a_k + d b_k) + (c a_(k+1) + d b_(k+1)) \
    &= sum_(i=1)^k (c a_i + d b_i) + c a_(k+1) + d b_(k+1) \
    &= c sum_(i=1)^k a_i + d sum_(i=1)^k b_i + c a_(k+1) + d b_(k+1) \
    &= c sum_(i=1)^(k+1) a_i + d sum_(i=1)^(k+1) b_i $
  となり、$n = k+1$ でも等しい。数学的帰納法により、すべての $n$ で成り立つ。
]

@lem-sum-const。$c$ を実数とするとき、$sum_(i=1)^n c = n c$ が成り立つ。
#proof[
  左辺は同じ数 $c$ を $n$ 個足したものである。$c$ でくくると $n c$ となる。
]

二重和の順序交換。$a_(i j)$ ($i = 1, ..., m$、$j = 1, ..., n$) を実数とするとき
$ sum_(i=1)^m sum_(j=1)^n a_(i j) = sum_(j=1)^n sum_(i=1)^m a_(i j) $
が成り立つ。
#proof[
  $m = 1$ のとき両辺は等しい。$n = 1$ のときも同様である。任意の $m, n$ で成り立つことは、次のように確かめられる。左辺の内側の和 $sum_(j=1)^n a_(i j)$ を $b_i$ と置くと、左辺は $sum_(i=1)^m b_i$ である。これを添字ごとに展開すれば
  $ sum_(i=1)^m sum_(j=1)^n a_(i j) = sum_(i=1)^m (a_(i 1) + a_(i 2) + ... + a_(i n)) $
  となる。右辺の括弧の中を $i$ について足し合わせると、$a_(i j)$ という各項が、すべての組み合わせ $(i, j)$ についてちょうど一度ずつ現れる。足し算は順序によらないので、同じ項の集まりを先に $j$ について足したものが右辺 $sum_(j=1)^n sum_(i=1)^m a_(i j)$ である。よって両辺は等しい。
]

和の積の分解。実数 $x_1, ..., x_m$ と $y_1, ..., y_n$ に対して
$ sum_(i=1)^m sum_(j=1)^n x_i y_j = (sum_(i=1)^m x_i)(sum_(j=1)^n y_j) $
が成り立つ。
#proof[
  左辺の内側の和に対して、$x_i$ は添字 $j$ に依らないので @lem-sum-linear により外に出せる。
  $ sum_(i=1)^m sum_(j=1)^n x_i y_j = sum_(i=1)^m x_i (sum_(j=1)^n y_j) = (sum_(i=1)^m x_i)(sum_(j=1)^n y_j) $
  2 番目の等号では、$sum_(j=1)^n y_j$ は添字 $i$ に依らない定数なので、定数倍として外に出した。
]

@lem-weighted-range（重み付き平均の範囲）。重み $w_1, ..., w_n$ がすべて $w_i >= 0$ であり、$a_"min" = min"{"a_1, ..., a_n"}"$、$a_"max" = max"{"a_1, ..., a_n"}"$ とするとき
$ a_"min" <= sum_(i=1)^n w_i a_i <= a_"max" $
が成り立つ。
#proof[
  すべての $i$ で $a_"min" <= a_i$ だから、$w_i >= 0$ を掛けても不等号は保たれ、$w_i a_"min" <= w_i a_i$ である。$i$ について足し合わせると
  $ sum_(i=1)^n w_i a_"min" <= sum_(i=1)^n w_i a_i $
  左辺は @lem-sum-const より $(sum_(i=1)^n w_i) a_"min" = a_"min"$ となる。上側の不等号も同様に示せる。
]

#heading(level: 2, numbering: none)[A.2　ベクトルと行列]

内積の三条の性質。任意の $n$ 次ベクトル $bold(u), bold(v), bold(w)$ と実数 $c$ に対して、次が成り立つ。
+ $bold(u)^T (bold(v) + bold(w)) = bold(u)^T bold(v) + bold(u)^T bold(w)$
+ $(c bold(u))^T bold(v) = c (bold(u)^T bold(v))$
+ $bold(v)^T bold(w) = bold(w)^T bold(v)$
#proof[
  1. は定義の右辺を成分で書くと
  $ sum_(i=1)^n u_i (v_i + w_i) = sum_(i=1)^n (u_i v_i + u_i w_i) = sum_(i=1)^n u_i v_i + sum_(i=1)^n u_i w_i $
  となり、@lem-sum-linear による。2. は $sum_(i=1)^n c u_i v_i = c sum_(i=1)^n u_i v_i$ である。3. は $v_i w_i = w_i v_i$ なので $i$ についての和も等しい。
]

@lem-transpose（転置の基本性質）。任意の $n$ 次正方行列 $bold(A), bold(B)$ と $n$ 次ベクトル $bold(v)$ に対して、次が成り立つ。
+ $(bold(A)^T)^T = bold(A)$
+ $(bold(A) bold(B))^T = bold(B)^T bold(A)^T$
+ $(bold(A) bold(v))^T = bold(v)^T bold(A)^T$
#proof[
  1. $(bold(A)^T)^T$ の第 $(i, j)$ 成分は、転置の定義を二度使って $bold(A)^T$ の第 $(j, i)$ 成分、すなわち $a_(i j)$ である。すべての成分が一致するので $(bold(A)^T)^T = bold(A)$ である。

  2. $(bold(A) bold(B))^T$ の第 $(i, j)$ 成分は、$bold(A) bold(B)$ の第 $(j, i)$ 成分
  $ sum_(k=1)^n a_(j k) b_(k i) $
  である。他方、$bold(B)^T bold(A)^T$ の第 $(i, j)$ 成分は行列の積の定義より
  $ sum_(k=1)^n (bold(B)^T)_(i k) (bold(A)^T)_(k j) = sum_(k=1)^n b_(k i) a_(j k) $
  であり、積の交換により両者は一致する。

  3. 2. で $bold(B)$ を $n times 1$ の行列（縦ベクトル）とみなすと、$bold(B)^T$ は横ベクトル $bold(v)^T$ になり、成分の計算は同じだから成り立つ。
]

単位行列との積。任意の $n$ 次正方行列 $bold(A)$ に対して $bold(A) bold(I) = bold(I) bold(A) = bold(A)$ が成り立つ。特に任意の $n$ 次ベクトル $bold(v)$ に対して $bold(I) bold(v) = bold(v)$ である。
#proof[
  $bold(A) bold(I)$ の第 $(i, j)$ 成分は行列の積の定義より $sum_(k=1)^n a_(i k) s_(k j)$ であり、$k = j$ の項だけが $a_(i j)$ として残る。ほかの項は $0$ である。よって $bold(A) bold(I) = bold(A)$ である。$bold(I) bold(A)$ も同様に、第 $(i, j)$ 成分が $sum_(k=1)^n s_(i k) a_(k j) = a_(i j)$ となる。
]

@cor-solve（連立一次方程式の解の一意性）。$bold(S)$ が正則ならば、任意の $n$ 次ベクトル $bold(b)$ に対して、$bold(S) bold(x) = bold(b)$ を満たすベクトル $bold(x)$ は $bold(x) = bold(S)^(-1) bold(b)$ としてただ一つ存在する。
#proof[
  まず $bold(x) = bold(S)^(-1) bold(b)$ が解であることを確かめる。行列の積とベクトルの積の結合は成分で確かめられる。すなわち任意の行列 $bold(A), bold(B)$ とベクトル $bold(v)$ に対して $(bold(A) bold(B)) bold(v) = bold(A) (bold(B) bold(v))$ が成り立つ。実際、左辺の第 $i$ 成分は
  $ sum_(j=1)^n (sum_(k=1)^n a_(i k) b_(k j)) v_j = sum_(k=1)^n a_(i k) (sum_(j=1)^n b_(k j) v_j) $
  であり、右辺の第 $i$ 成分に等しい。和の順序の入れ替えだけを使う計算である。これを使うと
  $ bold(S) (bold(S)^(-1) bold(b)) = (bold(S) bold(S)^(-1)) bold(b) = bold(I) bold(b) = bold(b) $
  となるので、$bold(S)^(-1) bold(b)$ は確かに解である。一意性について、$bold(S) bold(x)_1 = bold(S) bold(x)_2$ ならば、両辺の左から $bold(S)^(-1)$ を掛けると
  $ bold(x)_1 = bold(I) bold(x)_1 = (bold(S)^(-1) bold(S)) bold(x)_1 = bold(S)^(-1) (bold(S) bold(x)_1) = bold(S)^(-1) (bold(S) bold(x)_2) = bold(x)_2 $
  となる。よって解はただ一つである。
]

@lemma-pd-kernel（正定値行列の核）。$bold(S)$ が正定値ならば、$bold(S) bold(x) = bold(0)$ を満たす $bold(x)$ は $bold(x) = bold(0)$ に限る。
#proof[
  $bold(S) bold(x) = bold(0)$ を満たす $bold(x) != bold(0)$ が存在すると仮定する。$bold(S) bold(x)$ は零ベクトルなので、
  $ Q(bold(x)) = bold(x)^T (bold(S) bold(x)) = bold(x)^T bold(0) = 0 $
  である。他方、$bold(x) != bold(0)$ と正定値の定義より $Q(bold(x)) > 0$ であり、矛盾する。したがって $bold(x) = bold(0)$ に限る。
]

@lem-cs-weighted（拡張されたコーシー・シュワルツの不等式）。$bold(Sigma)$ を正定値な $n$ 次対称行列とするとき、任意の $n$ 次ベクトル $bold(u), bold(v)$ に対して
$ (bold(u)^T bold(v))^2 <= (bold(u)^T bold(Sigma) bold(u)) (bold(v)^T bold(Sigma)^(-1) bold(v)) $
が成り立つ。等号は $bold(u)$ と $bold(Sigma)^(-1) bold(v)$ が平行であるとき、すなわち $bold(u) = c bold(Sigma)^(-1) bold(v)$ または $bold(v) = c bold(Sigma) bold(u)$（$c$ は実数）と表されるときに限る。
#proof[
  まず $bold(Sigma)^(-1)$ が存在し、正定値な対称行列であることを確認する。正定値行列は正則である（@rem-pd-regular）。$bold(Sigma)^(-1)$ の対称性は $bold(Sigma)$ の対称性から従う。また $bold(x) != bold(0)$ のとき
  $ bold(x)^T bold(Sigma)^(-1) bold(x) = (bold(Sigma)^(-1) bold(x))^T bold(Sigma) (bold(Sigma)^(-1) bold(x)) > 0 $
  なので正定値である。

  $bold(u) = bold(0)$ の場合は左辺も右辺も $0$ であり等号が成り立つ。零ベクトルは任意のベクトルと平行とみなすことにすれば、以下 $bold(u) != bold(0)$ としてよい。実数 $t$ に対して、$t$ の2次関数
  $ q(t) = (t bold(u) + bold(Sigma)^(-1) bold(v))^T bold(Sigma) (t bold(u) + bold(Sigma)^(-1) bold(v)) = t^2 (bold(u)^T bold(Sigma) bold(u)) + 2 t (bold(u)^T bold(v)) + bold(v)^T bold(Sigma)^(-1) bold(v) $
  を考える。展開の $t$ の1次の項は $bold(u)^T bold(Sigma) bold(Sigma)^(-1) bold(v) = bold(u)^T bold(v)$ による。$t^2$ の係数 $bold(u)^T bold(Sigma) bold(u)$ は、$bold(u) != bold(0)$ と正定値性より正である。したがって $q$ のグラフは下に凸の放物線である。

  まず $bold(u)$ と $bold(Sigma)^(-1) bold(v)$ が平行でない場合を考える。このとき、任意の実数 $t$ に対して $t bold(u) + bold(Sigma)^(-1) bold(v) != bold(0)$ である。実際、このベクトルが $bold(0)$ ならば $bold(Sigma)^(-1) bold(v) = -t bold(u)$ となり平行に矛盾する。よって正定値性より $q(t) > 0$ がすべての $t$ で成り立つ。下に凸の放物線がすべての $t$ で正の値をとるのは、$t$ 軸と共有点を持たないとき、すなわち判別式が負のときに限る。ゆえに
  $ (bold(u)^T bold(v))^2 - (bold(u)^T bold(Sigma) bold(u)) (bold(v)^T bold(Sigma)^(-1) bold(v)) < 0 $
  であり、不等号は厳密である。

  次に $bold(u)$ と $bold(Sigma)^(-1) bold(v)$ が平行な場合、ある実数 $t_0$ によって $bold(Sigma)^(-1) bold(v) = -t_0 bold(u)$、すなわち $bold(v) = -t_0 bold(Sigma) bold(u)$ と書ける。このとき
  $ bold(u)^T bold(v) = -t_0 (bold(u)^T bold(Sigma) bold(u)), quad bold(v)^T bold(Sigma)^(-1) bold(v) = t_0^2 (bold(u)^T bold(Sigma) bold(u)) $
  なので、両辺を計算すると
  $ (bold(u)^T bold(v))^2 = t_0^2 (bold(u)^T bold(Sigma) bold(u))^2 = (bold(u)^T bold(Sigma) bold(u)) (bold(v)^T bold(Sigma)^(-1) bold(v)) $
  であり、等号が成立する。以上より不等式が成り立ち、等号になるのは $bold(u)$ と $bold(Sigma)^(-1) bold(v)$ が平行であるときに限る。
]

@cor-cs-vector（ベクトルに対するコーシー・シュワルツの不等式）。任意の $n$ 次ベクトル $bold(u), bold(v)$ に対して
$ (bold(u)^T bold(v))^2 <= (bold(u)^T bold(u)) (bold(v)^T bold(v)) $
が成り立つ。等号は $bold(u)$ と $bold(v)$ が平行であるときに限る。
#proof[
  @lem-cs-weighted で $bold(Sigma) = bold(I)$ とする。$bold(I)$ は、$bold(v)^T bold(I) bold(v) = sum_(i=1)^n v_i^2 > 0$（$bold(v) != bold(0)$）より正定値であり、$bold(I)^(-1) = bold(I)$ なので主張の不等式が得られる。等号条件 $bold(v) = c bold(Sigma) bold(u)$ は $bold(v) = c bold(u)$ と同じであり、$bold(u)$ と $bold(v)$ が平行であることを意味する。
]

#heading(level: 2, numbering: none)[A.3　微分と二次関数の最小化]

@lem-dx2。$f(x) = x^2$ の導関数は $f'(x) = 2x$ である。
#proof[
  定義より
  $ f'(x) = lim_(h -> 0) ((x + h)^2 - x^2) / h = lim_(h -> 0) (2 x h + h^2) / h = lim_(h -> 0) (2 x + h) $
  $h -> 0$ のとき $2 x + h -> 2x$ なので、$f'(x) = 2x$ である。
]

微分の線形性。関数 $f, g$ と実数 $c$ に対して、$(f + g)' = f' + g'$ と $(c f)' = c f'$ が成り立つ。
#proof[
  微分係数の定義を書き、分子を整理する。
  $ lim_(h -> 0) ((f + g)(x + h) - (f + g)(x)) / h = lim_(h -> 0) (f(x + h) - f(x)) / h + lim_(h -> 0) (g(x + h) - g(x)) / h $
  右辺の二つの極限は $f'(x)$ と $g'(x)$ である。定数倍も同様に、分子から $c$ がくくり出せることから示される。
]

@eq-quad-min（二次関数の最小値）。$a > 0$ とし、$f(x) = a x^2 + b x + c$ とする。このとき $f$ は $x = -b\/(2a)$ で最小値 $c - b^2\/(4a)$ をとる。
#proof[
  $f(x)$ を次のように変形する。
  $ f(x) = a (x + b\/(2a))^2 + c - b^2\/(4a) $
  この変形は右辺を展開すると左辺と一致することから確かめられる。第一項は $a > 0$ と平方の性質より $a (x + b\/(2a))^2 >= 0$ で、$x = -b\/(2a)$ のとき $0$ になる。よって $f$ は $x = -b\/(2a)$ で最小値 $c - b^2\/(4a)$ をとる。微分係数を使うなら、@lem-dx2 より $f'(x) = 2 a x + b$ であり、$f'(x) = 0$ と解いて同じ $x$ が得られる。
]

@lem-quad2（二変数の二次関数の正値性）。$a > 0$ かつ $a c - b^2 > 0$ とし
$ f(x, y) = a x^2 + 2 b x y + c y^2 $
とする。このとき任意の $(x, y) != (0, 0)$ に対して $f(x, y) > 0$ であり、$f(0, 0) = 0$ である。特に $f$ は原点で最小値 $0$ をとる。
#proof[
  $y = 0$ のとき、$f(x, 0) = a x^2$ であり、$x != 0$ なら $a > 0$ より正である。$y != 0$ のとき、$f$ を次のように変形する。
  $ f(x, y) = a (x + (b\/a) y)^2 + (a c - b^2)\/a y^2 $
  この変形は右辺を展開して確かめられる。第一項は $0$ 以上、第二項は仮定 $a c - b^2 > 0$ と $y != 0$ より正である。よって $f(x, y) > 0$ である。$(x, y) = (0, 0)$ のとき明らかに $f(0, 0) = 0$ である。
]
