#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, appendix-count, term-meta

#appendix-count.update(2)

#heading(numbering: none)[付録B　第3章の定理の証明]

この付録では、第 3 章で述べた定理と補題の証明を与える。証明に使うのは、積分の線形性、積分の順序の入れ替え、積分の単調性という、高校数学の範囲の性質のみである。

#heading(level: 2, numbering: none)[B.1　積分の準備]

関数 $f$ の区間 $[a, b]$ での定積分
$ integral_a^b f(x) dif x $
#par(first-line-indent: (amount: 0pt))[は、区間を細かく分けて長方形の面積の和を取り、分割を限りなく細かくした極限として定義される。]全区間での積分は $integral_(-oo)^(oo) f(x) dif x$ と書く。本付録で使う性質は次の三つである。

+ （積分の線形性）定数 $c, d$ と関数 $f, g$ に対して
  $ integral_(-oo)^(oo) (c f(x) + d g(x)) dif x = c integral_(-oo)^(oo) f(x) dif x + d integral_(-oo)^(oo) g(x) dif x $
+ （積分の順序の入れ替え）二変数の関数 $h$ の二重積分は、逐次的な積分として計算できる。すなわち
  $ integral_(-oo)^(oo) integral_(-oo)^(oo) h(x, y) dif x dif y = integral_(-oo)^(oo) (integral_(-oo)^(oo) h(x, y) dif x) dif y $
  #par(first-line-indent: (amount: 0pt))[のように、どちらの順序で計算しても同じ値になる。この事実はフビニの定理として知られる標準的な結果であり、本書では結果として採用する。]
+ （積分の単調性）すべての $x$ で $f(x) <= g(x)$ が成り立つならば
  $ integral_(-oo)^(oo) f(x) dif x <= integral_(-oo)^(oo) g(x) dif x $
  が成り立つ。差 $g - f >= 0$ の積分が非負であることによる。

#heading(level: 2, numbering: none)[B.2　期待値の性質]

@thm-linear（期待値の線形性）。確率変数 $X, Y$ と実数 $a, b$ に対して
$ E[a X + b Y] = a E[X] + b E[Y] $
が成り立つ。
#proof[
  $X$ と $Y$ の同時密度を $f(x, y)$ とすると、$a X + b Y$ の期待値は $h(x, y) = (a x + b y) f(x, y)$ の二重積分として書ける。B.1 節の積分の線形性により
  $ E[a X + b Y] = integral_(-oo)^(oo) integral_(-oo)^(oo) (a x + b y) f(x, y) dif x dif y = a integral_(-oo)^(oo) integral_(-oo)^(oo) x f(x, y) dif x dif y + b integral_(-oo)^(oo) integral_(-oo)^(oo) y f(x, y) dif x dif y $
  第 1 項の内側の積分を先に計算すると、$integral_(-oo)^(oo) x f(x, y) dif x$ に $y$ についての積分が続く形になる。ここで $X$ の周辺密度
  $ f_X(x) = integral_(-oo)^(oo) f(x, y) dif y $
  を使い、フビニの定理より
  $ integral_(-oo)^(oo) integral_(-oo)^(oo) x f(x, y) dif x dif y = integral_(-oo)^(oo) x f_X(x) dif x = E[X] $
  である。第 2 項も同様に $E[Y]$ に等しい。よって主張の等式が成り立つ。
]

@cor-const（定数の期待値）。確率変数 $X$ と実数 $c$ に対して $E[c] = c$ が成り立つ。
#proof[
  定数 $c$ は密度によらず常に同じ値 $c$ をとる量であり、期待値の定義と $integral_(-oo)^(oo) f(x) dif x = 1$ より
  $ E[c] = integral_(-oo)^(oo) c f(x) dif x = c integral_(-oo)^(oo) f(x) dif x = c $
  である。
]

期待値の単調性。$X <= Y$ を満たす確率変数 $X, Y$ に対して $E[X] <= E[Y]$ である。
#proof[
  $X <= Y$ とは、両者の値が常にこの順序で実現することである。$X$ と $Y$ の同時密度を $f(x, y)$ とすると、差の期待値は
  $ E[Y] - E[X] = integral integral (y - x) f(x, y) dif x dif y $
  と書ける。被積分関数は $y - x >= 0$ と $f >= 0$ より非負なので、積分の単調性より $E[Y] - E[X] >= 0$ である。
]

#heading(level: 2, numbering: none)[B.3　分散と共分散の性質]

@lem-var-alt（分散の別表現）。分散は $V[X] = E[X^2] - (E[X])^2$ と書き直せる。
#proof[
  $X - E[X]$ を $Z$ と置く。$E[Z] = E[X] - E[E[X]]$ であり、$E[X]$ は実数なので @cor-const より $E[E[X]] = E[X]$ である。よって $E[Z] = 0$ である。このとき
  $ V[X] = E[Z^2] = E[(X - E[X])^2] = E[X^2 - 2 E[X] X + (E[X])^2] $
  右辺の期待値に @thm-linear を適用すると
  $ = E[X^2] - 2 E[X] E[X] + (E[X])^2 = E[X^2] - (E[X])^2 $
  となる。
]

@cor-var-affine（アフィン変換の分散）。実数 $a, b$ と確率変数 $X$ に対して $V[a X + b] = a^2 V[X]$ が成り立つ。
#proof[
  $E[a X + b] = a E[X] + b$ であるから
  $ V[a X + b] &= E[(a X + b - a E[X] - b)^2] = E[a^2 (X - E[X])^2] \
    &= a^2 E[(X - E[X])^2] = a^2 V[X] $
  である。途中で @thm-linear を使った。
]

@lem-degenerate（分散がゼロなら確率 1 で定数）。$V[X] = 0$ ならば、$P(X = E[X]) = 1$ である。
#proof[
  $epsilon > 0$ に対して、$|x - E[X]| >= epsilon$ となる $x$ では $(x - E[X])^2 >= epsilon^2$ が成り立つ。@eq-continuous-prob より
  $ V[X] = integral_(-oo)^(oo) (x - E[X])^2 f(x) dif x >= epsilon^2 P(|X - E[X]| >= epsilon) $
  である。$V[X] = 0$ ならば左辺が $0$ なので、$P(|X - E[X]| >= epsilon) = 0$ がすべての $epsilon > 0$ で成り立つ。よって $P(X = E[X]) = 1$ である。
]

@lem-cov-alt（共分散の別表現）。$"Cov"[X, Y] = E[X Y] - E[X] E[Y]$ が成り立つ。
#proof[
  $(X - E[X])(Y - E[Y])$ を展開すると
  $ X Y - X E[Y] - E[X] Y + E[X] E[Y] $
  である。@thm-linear と、実数 $E[X], E[Y]$ が積分の外に出ることを使うと
  $ "Cov"[X, Y] = E[X Y] - E[Y] E[X] - E[X] E[Y] + E[X] E[Y] = E[X Y] - E[X] E[Y] $
  となる。
]

@lem-cov-linear（共分散の線形性）。確率変数 $X, Y_1, ..., Y_n$ と実数 $a_1, ..., a_n$ に対して
$ "Cov"[X, sum_(j=1)^n a_j Y_j] = sum_(j=1)^n a_j "Cov"[X, Y_j] $
が成り立つ。
#proof[
  $sum_(j=1)^n a_j Y_j$ の期待値は $sum_(j=1)^n a_j E[Y_j]$ である。共分散の定義に戻ると
  $ "Cov"[X, sum_(j=1)^n a_j Y_j] &= E[(X - E[X]) (sum_(j=1)^n a_j Y_j - sum_(j=1)^n a_j E[Y_j])] \
    &= E[(X - E[X]) sum_(j=1)^n a_j (Y_j - E[Y_j])] $
  $sum_(j=1)^n a_j (Y_j - E[Y_j])$ を一つの確率変数とみなして和の記号を期待値の外に出す操作は、@thm-linear そのものである。よって
  $ = sum_(j=1)^n a_j E[(X - E[X])(Y_j - E[Y_j])] = sum_(j=1)^n a_j "Cov"[X, Y_j] $
  となる。
]

@thm-var-sum（分散の加法性）。実数 $a, b$ と確率変数 $X, Y$ に対して
$ V[a X + b Y] = a^2 V[X] + 2 a b "Cov"[X, Y] + b^2 V[Y] $
が成り立つ。
#proof[
  $mu_X = E[X]$、$mu_Y = E[Y]$ と置く。$a X + b Y$ の期待値は $a mu_X + b mu_Y$ である。分散の定義に戻って展開する。
  $ V[a X + b Y] &= E[(a(X - mu_X) + b(Y - mu_Y))^2] \
    &= E[a^2 (X - mu_X)^2 + 2 a b (X - mu_X)(Y - mu_Y) + b^2 (Y - mu_Y)^2] $
  最後の式の三つの項に @thm-linear を適用すると
  $ = a^2 E[(X - mu_X)^2] + 2 a b E[(X - mu_X)(Y - mu_Y)] + b^2 E[(Y - mu_Y)^2] $
  となる。第一項は $a^2 V[X]$、第三項は $b^2 V[Y]$、中央の項は共分散の定義そのものである。よって主張の等式が成り立つ。
]

@thm-cs（確率変数に対するコーシー・シュワルツの不等式）。確率変数 $X, Y$ に対して
$ ("Cov"[X, Y])^2 <= V[X] V[Y] $
が成り立つ。
#proof[
  $V[X] = 0$ の場合、@lem-degenerate より $X$ は確率 $1$ で定数 $mu_X$ に等しい。このとき $X - mu_X$ は確率 $1$ で $0$ なので $"Cov"[X, Y] = E[0 dot.c (Y - mu_Y)] = 0$ であり、両辺とも $0$ で等しい。

  $V[X] > 0$ の場合を考える。実数 $t$ を一つ選ぶと、$t(X - mu_X) + (Y - mu_Y)$ も確率変数であり、その分散は非負である。@thm-var-sum を適用すると
  $ 0 <= V[t (X - mu_X) + (Y - mu_Y)] = t^2 V[X] + 2 t "Cov"[X, Y] + V[Y] $
  この2次式はすべての実数 $t$ で非負である。$V[X] > 0$ より下に凸の放物線なので、判別式は $0$ 以下である。すなわち
  $ ("Cov"[X, Y])^2 - V[X] V[Y] <= 0 $
  これが主張の不等式である。
]

相関係数の値域。$V[X] > 0$ かつ $V[Y] > 0$ のとき
$ rho_(X Y) = "Cov"[X, Y] \/ (sqrt(V[X]) sqrt(V[Y])) $
と定めると、$-1 <= rho_(X Y) <= 1$ が成り立つ。
#proof[
  @eq-cauchy の両辺を正の数 $V[X] V[Y]$ で割ると $rho_(X Y)^2 <= 1$ が得られる。$rho_(X Y)^2 <= 1$ は $-1 <= rho_(X Y) <= 1$ と同値である。
]

#heading(level: 2, numbering: none)[B.4　正規分布の期待値と分散]

第 3 章では、正規分布 $N(mu, sigma^2)$ の期待値が $mu$、分散が $sigma^2$ であることを結果として使った。この節で証明する。証明の出発点として、次の積分を解析学の標準的な結果として採用する。

#lemma[
  （ガウス積分）
  $ integral_(-oo)^(oo) e^(-z^2 \/ 2) dif z = sqrt(2 pi) $ <eq-gauss>
]

この積分は、両辺の2乗を二重積分に直して極座標に変換すると計算できることが知られている。変数を二つに増やした積分の理論は本書の範囲を超えるため、ここでは結果だけを用いる。

#theorem[
  $X$ が $N(mu, sigma^2)$ に従うならば $E[X] = mu$、$V[X] = sigma^2$ である。さらに、任意の関数 $h$ の期待値 $E[h(X)]$ は、$h$ の形以外には $mu$ と $sigma$ だけに依存する。
]<thm-normal-moments>

#proof[
  証明は四つの段階からなる。

  第一段階として、$Z = (X - mu)\/sigma$ と置き換える。正規分布の密度 @def-normal に対して、置換積分 $x = mu + sigma z$、$dif x = sigma dif z$ を適用すると、任意の関数 $h$ について
  $ integral_(-oo)^(oo) h(x) f(x) dif x = integral_(-oo)^(oo) h(mu + sigma z) phi(z) dif z, quad phi(z) = 1\/sqrt(2 pi) e^(-z^2\/2) $
  である。$x$ と $z$ の関係式 $(x - mu)^2\/sigma^2 = z^2$ を使い、係数 $1\/(sqrt(2 pi) sigma)$ に $dif x = sigma dif z$ の $sigma$ が約分されて $phi$ の係数 $1\/sqrt(2 pi)$ が残る。この等式は、$h$ の期待値が $h$ の形のほかには $mu$ と $sigma$ だけを通じて現れることを示しており、主張の後半である。$phi$ 自身が密度関数であること、すなわち $integral phi(z) dif z = 1$ は @eq-gauss から $1\/sqrt(2 pi) dot.c sqrt(2 pi) = 1$ として従う。したがって $Z$ は密度 $phi$ に従い、$X = mu + sigma Z$ である。

  第二段階として、$E[Z] = 0$ を示す。被積分関数 $z phi(z)$ は奇関数、すなわち $z -> -z$ の置き換えで符号が反転する。積分区間が原点に対して対称なので、$z > 0$ の部分と $z < 0$ の部分が打ち消し合い、積分は $0$ になる。

  第三段階として、$E[Z^2] = 1$ を示す。$e^(-z^2\/2)$ の導関数が $-z e^(-z^2\/2)$ であることを使うと、部分積分により
  $ integral_(-oo)^(oo) z^2 e^(-z^2\/2) dif z = -integral_(-oo)^(oo) z (e^(-z^2\/2))' dif z = -[z e^(-z^2\/2)]_(-oo)^(oo) + integral_(-oo)^(oo) e^(-z^2\/2) dif z $
  である。第一項の $z e^(-z^2\/2)$ は $z -> plus.minus oo$ で $0$ に収束する。$e^(-z^2\/2)$ の減衰の速さが $z$ の増大に勝つためである。よって @eq-gauss から
  $ E[Z^2] = 1\/sqrt(2 pi) integral_(-oo)^(oo) z^2 e^(-z^2\/2) dif z = 1\/sqrt(2 pi) dot.c sqrt(2 pi) = 1 $
  である。

  第四段階として、$X$ に戻す。$X = mu + sigma Z$ に @thm-linear を適用すると $E[X] = mu + sigma E[Z] = mu$ である。分散については @cor-var-affine より $V[X] = sigma^2 V[Z]$ であり、$V[Z] = E[Z^2] - (E[Z])^2 = 1 - 0 = 1$（@lem-var-alt の別表現）だから $V[X] = sigma^2$ である。
]
