#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta

= 数学の準備

本書の議論は、和の記号、ベクトルと行列、そして2次関数の最小化という三つの道具の上に組み上げられる。この章でそれらを導入し、あとの章で使う性質を補題と定理の形に整える。高校数学を超える内容はすべてこの章と次の章で定義から整える。この章の補題・定理・系の証明は付録Aにまとめて述べる。

== 和の記号

=== 定義と基本性質

同じ形の量を多数足すとき、記号 $Sigma$ を使って和を短く書く。

#definition[
  $n$ を自然数とし、$a_1, a_2, ..., a_n$ を実数とする。このとき
  $ sum_(i=1)^n a_i = a_1 + a_2 + ... + a_n $
  と書き、下付きの文字 $i$ を#term-meta((kana: "そえじ", ja: "添字", en: "index"))#strong[添字]（index）、この表記を#term-meta((kana: "わのきごう", ja: "和の記号", en: "summation symbol"))#strong[和の記号]（summation symbol）と呼ぶ。$Sigma$ の下と上の数は、添字 $i$ を $1$ から $n$ まで動かすことを示す。
]

和の記号は次の性質により計算に耐える道具になる。

#lemma[
  $c, d$ を実数とするとき、任意の $n$ に対して
  $ sum_(i=1)^n (c a_i + d b_i) = c sum_(i=1)^n a_i + d sum_(i=1)^n b_i $
  が成り立つ。#term-meta((kana: "わのせんけいせい", ja: "和の線形性", en: "linearity of summation"))#strong[和の線形性]（linearity of summation）と呼ばれる性質である。
]<lem-sum-linear>

#lemma[
  $c$ を実数とするとき、$sum_(i=1)^n c = n c$ が成り立つ。
]<lem-sum-const>

次の二重和の性質は付録で積分や和の順序を入れ替えるときの根拠になる。

#lemma[
  $a_(i j)$ ($i = 1, ..., m$、$j = 1, ..., n$) を実数とするとき
  $ sum_(i=1)^m sum_(j=1)^n a_(i j) = sum_(j=1)^n sum_(i=1)^m a_(i j) $
  が成り立つ。
]

#lemma[
  実数 $x_1, ..., x_m$ と $y_1, ..., y_n$ に対して
  $ sum_(i=1)^m sum_(j=1)^n x_i y_j = (sum_(i=1)^m x_i)(sum_(j=1)^n y_j) $
  が成り立つ。
]

=== 重み付き平均

本書では資産への投資比率を成分とする重み付き平均が繰り返し現れる。ここで一般形を定義しておく。

#definition[
  実数 $w_1, ..., w_n$ が $w_1 + w_2 + ... + w_n = 1$ を満たすとき、これらを#term-meta((kana: "おもみ", ja: "重み", en: "weight"))#strong[重み]（weight）と呼ぶ。重みと実数 $a_1, ..., a_n$ に対して
  $ sum_(i=1)^n w_i a_i = w_1 a_1 + w_2 a_2 + ... + w_n a_n $
  を $a_1, ..., a_n$ の#term-meta((kana: "おもみつきへいきん", ja: "重み付き平均", en: "weighted average"))#strong[重み付き平均]（weighted average）と呼ぶ。
]

重みがすべて非負で和が $1$ であるとき、重み付き平均は各 $a_i$ の最小値以上最大値以下に収まる。この事実を補題の形で残しておく。

#lemma[
  重み $w_1, ..., w_n$ がすべて $w_i >= 0$ であり、$a_"min" = min"{"a_1, ..., a_n"}"$、$a_"max" = max"{"a_1, ..., a_n"}"$ とするとき
  $ a_"min" <= sum_(i=1)^n w_i a_i <= a_"max" $
  が成り立つ。
]<lem-weighted-range>

== ベクトルと行列

=== ベクトル

$n$ 個の実数を縦に並べたものをベクトルと呼び、本書の理論を短い式で書くための記法として使う。

#definition[
  実数 $v_1, ..., v_n$ を縦に並べた
  $ bold(v) = vec(v_1, v_2, dots.v, v_n) $
  を $n$ 次#term-meta((kana: "べくとる", ja: "ベクトル", en: "vector"))#strong[ベクトル]（vector）と呼ぶ。$v_i$ を $bold(v)$ の第 $i$ 成分と呼ぶ。成分がすべて $1$ の $n$ 次ベクトルを $bold(1)$ と書く。
]

#definition[
  ベクトル $bold(v)$ と実数 $c$ に対して、$c bold(v)$ を第 $i$ 成分が $c v_i$ のベクトルと定める。ベクトル $bold(v), bold(w)$ の和 $bold(v) + bold(w)$ を第 $i$ 成分が $v_i + w_i$ のベクトルと定める。
]

#definition[
  二つの $n$ 次ベクトル $bold(v), bold(w)$ に対して
  $ bold(v)^T bold(w) = v_1 w_1 + v_2 w_2 + ... + v_n w_n = sum_(i=1)^n v_i w_i $
  を $bold(v)$ と $bold(w)$ の#term-meta((kana: "ないせき", ja: "内積", en: "inner product"))#strong[内積]（inner product）と呼ぶ。記号 $T$ は転置を表し、縦ベクトル $bold(v)$ を横に並べ替えたものを $bold(v)^T$ と書く。
]<def-inner-product>

内積について、本書で使う性質は次の三条である。いずれも成分を書き下せば確かめられる。

#lemma[
  任意の $n$ 次ベクトル $bold(u), bold(v), bold(w)$ と実数 $c$ に対して、次が成り立つ。
  + $bold(u)^T (bold(v) + bold(w)) = bold(u)^T bold(v) + bold(u)^T bold(w)$
  + $(c bold(u))^T bold(v) = c (bold(u)^T bold(v))$
  + $bold(v)^T bold(w) = bold(w)^T bold(v)$
]

=== 行列

$n$ 個の資産の分散と共分散を一括して扱うために、行列の記法を導入する。

#definition[
  実数 $s_(i j)$ ($i = 1, ..., n$、$j = 1, ..., n$) を正方形状に並べた
  $ bold(S) = mat(s_(1 1), s_(1 2), dots.c, s_(1 n); s_(2 1), s_(2 2), dots.c, s_(2 n); dots.v, dots.v, , dots.v; s_(n 1), s_(n 2), dots.c, s_(n n)) $
  を $n$ 次#term-meta((kana: "せいほうぎょうれつ", ja: "正方行列", en: "square matrix"))#strong[正方行列]（square matrix）と呼ぶ。$s_(i j)$ を第 $(i, j)$ 成分と呼ぶ。$s_(i j) = s_(j i)$ がすべての $i, j$ で成り立つとき、$bold(S)$ は#strong[対称]（symmetric）であると言う。
]

#definition[
  行列 $bold(S)$ と $n$ 次ベクトル $bold(v)$ の積 $bold(S) bold(v)$ を、第 $i$ 成分が
  $ sum_(j=1)^n s_(i j) v_j $
  である $n$ 次ベクトルと定める。$bold(S) bold(v)$ の第 $i$ 成分は、$bold(S)$ の第 $i$ 行 $(s_(i 1), ..., s_(i n))$ と $bold(v)$ の内積になっている。
]

#definition[
  $n$ 次正方行列 $bold(A)$ と $bold(B)$ の積 $bold(A) bold(B)$ を、第 $(i, j)$ 成分が
  $ sum_(k=1)^n a_(i k) b_(k j) $
  である $n$ 次正方行列と定める。
]

#definition[
  行列 $bold(A)$ に対して、第 $(i, j)$ 成分が $a_(j i)$ である行列を $bold(A)$ の#strong[転置行列]（transpose）と呼び、$bold(A)^T$ と書く。縦ベクトルの転置はすでに @def-inner-product で導入した記号と同じ規則である。$bold(S)^T = bold(S)$ が成り立つとき、$bold(S)$ は対称であると言う。これは $s_(i j) = s_(j i)$ がすべての $i, j$ で成り立つことと同じ条件である。
]<def-transpose>

#lemma[
  （転置の基本性質）任意の $n$ 次正方行列 $bold(A), bold(B)$ と $n$ 次ベクトル $bold(v)$ に対して、次が成り立つ。
  + $(bold(A)^T)^T = bold(A)$
  + $(bold(A) bold(B))^T = bold(B)^T bold(A)^T$
  + $(bold(A) bold(v))^T = bold(v)^T bold(A)^T$
]<lem-transpose>

#definition[
  $s_(i j) = 1$ ($i = j$)、$s_(i j) = 0$ ($i != j$) の行列を#strong[単位行列]（identity matrix）と呼び、$bold(I)$ と書く。
]

#corollary[
  任意の $n$ 次正方行列 $bold(A)$ に対して $bold(A) bold(I) = bold(I) bold(A) = bold(A)$ が成り立つ。特に任意の $n$ 次ベクトル $bold(v)$ に対して $bold(I) bold(v) = bold(v)$ である。
]

#definition[
  $n$ 次正方行列 $bold(S)$ に対して、
  $ bold(S) bold(S)^(-1) = bold(S)^(-1) bold(S) = bold(I) $ <eq-inverse-def>
  を満たす行列 $bold(S)^(-1)$ が存在するとき、$bold(S)$ は#term-meta((kana: "せいそく", ja: "正則", en: "nonsingular"))#strong[正則]（nonsingular）であると言い、$bold(S)^(-1)$ を $bold(S)$ の#term-meta((kana: "ぎゃくぎょうれつ", ja: "逆行列", en: "inverse matrix"))#strong[逆行列]（inverse matrix）と呼ぶ。
]<def-inverse>

#corollary[
  $bold(S)$ が正則ならば、任意の $n$ 次ベクトル $bold(b)$ に対して、$bold(S) bold(x) = bold(b)$ を満たすベクトル $bold(x)$ は $bold(x) = bold(S)^(-1) bold(b)$ としてただ一つ存在する。
]<cor-solve>

#definition[
  対称行列 $bold(S)$ と $n$ 次ベクトル $bold(v)$ に対して、
  $ Q(bold(v)) = bold(v)^T bold(S) bold(v) $
  を $bold(S)$ に関する#term-meta((kana: "にじけいしき", ja: "二次形式", en: "quadratic form"))#strong[二次形式]（quadratic form）と呼ぶ。すべての $bold(v) != bold(0)$ に対して $Q(bold(v)) > 0$ が成り立つとき、$bold(S)$ は#term-meta((kana: "せいていち", ja: "正定値", en: "positive definite"))#strong[正定値]（positive definite）であると言う。
]<def-quadratic>

二次形式はベクトルの成分の2次多項式である。$n = 1$ の場合は $Q(bold(v)) = s_(1 1) v_1^2$ である。$n = 2$ の場合は対称性 $s_(1 2) = s_(2 1)$ を使って
$ Q(bold(v)) = s_(1 1) v_1^2 + 2 s_(1 2) v_1 v_2 + s_(2 2) v_2^2 $
と書ける。@lem-quad2 は、$a = s_(1 1)$、$b = s_(1 2)$、$c = s_(2 2)$ として $2 times 2$ の対称行列の二次形式が正定値である十分条件を与える例になっている。第 5 章で見るように、ポートフォリオの分散は分散共分散行列の二次形式として表される。

#lemma[
  $bold(S)$ が正定値ならば、$bold(S) bold(x) = bold(0)$ を満たす $bold(x)$ は $bold(x) = bold(0)$ に限る。
]<lemma-pd-kernel>

#remark[
  連立一次方程式の理論（ガウスの消去法）によれば、$bold(S) bold(x) = bold(0)$ の解が $bold(x) = bold(0)$ に限ることと、$bold(S)$ が正則であることは同値である。したがって正定値行列は正則である。この同値性の証明は線形代数の標準的な結果であり本書の範囲を超えるため、ここでは結果のみを用いる。第 5 章以降では分散共分散行列 $bold(Sigma)$ の正則性を仮定として明示するが、実際には $bold(Sigma)$ が正定値であることが @lemma-var-pos で示されるので、仮定は自動的に満たされる。
]<rem-pd-regular>

=== 拡張されたコーシー・シュワルツの不等式

内積の大きさをそれぞれの重み付きの大きさと比較する不等式として、コーシー・シュワルツの不等式を正定値行列で拡張した形のものを述べる。この形の不等式は多変量解析の標準的な結果である @johnson2013。証明は2次関数の判別式による。

#lemma[
  $bold(Sigma)$ を正定値な $n$ 次対称行列とするとき、任意の $n$ 次ベクトル $bold(u), bold(v)$ に対して
  $ (bold(u)^T bold(v))^2 <= (bold(u)^T bold(Sigma) bold(u)) (bold(v)^T bold(Sigma)^(-1) bold(v)) $ <eq-cs-weighted>
  が成り立つ。等号は $bold(u)$ と $bold(Sigma)^(-1) bold(v)$ が平行であるとき、すなわち $bold(u) = c bold(Sigma)^(-1) bold(v)$ または $bold(v) = c bold(Sigma) bold(u)$（$c$ は実数）と表されるときに限る。
]<lem-cs-weighted>

#corollary[
  （ベクトルに対するコーシー・シュワルツの不等式）任意の $n$ 次ベクトル $bold(u), bold(v)$ に対して
  $ (bold(u)^T bold(v))^2 <= (bold(u)^T bold(u)) (bold(v)^T bold(v)) $ <eq-cs-vector>
  が成り立つ。等号は $bold(u)$ と $bold(v)$ が平行であるときに限る。
]<cor-cs-vector>

== 微分と二次関数の最小化

=== 一変数関数の微分

本書で最小化する対象はすべて多項式であり、微分は高校の数学 III で学ぶ導関数の定義のまま使う。

#definition[
  関数 $f$ と実数 $x$ に対して、極限
  $ f'(x) = lim_(h -> 0) (f(x + h) - f(x)) / h $
  が存在するとき、$f'(x)$ を $x$ における#term-meta((kana: "びぶんけいすう", ja: "微分係数", en: "derivative"))#strong[微分係数]（derivative）と呼ぶ。$x$ の各点で微分係数が存在するとき、$x$ に $f'(x)$ を対応させる関数を#strong[導関数]（derivative）と呼ぶ。
]

#lemma[
  $f(x) = x^2$ の導関数は $f'(x) = 2x$ である。
]<lem-dx2>

#lemma[
  関数 $f, g$ と実数 $c$ に対して、$(f + g)' = f' + g'$ と $(c f)' = c f'$ が成り立つ。
]

最小値の存在と微分係数の関係を、本書で使う形で定理として述べておく。

#theorem[
  $a > 0$ とし、$f(x) = a x^2 + b x + c$ とする。このとき $f$ は $x = -b\/(2a)$ で最小値 $c - b^2\/(4a)$ をとる。
]<eq-quad-min>

=== 二変数の二次関数

ポートフォリオの分散は重みを成分とするベクトルの2次形式として書かれる。2 資産の場合に必要な二変数の2次関数の最小化を、ここで準備する。

#definition[
  二変数関数 $f(x, y)$ の $x$ についての偏微分係数とは、$y$ を固定したときの、$x$ の関数としての微分係数である。記号では
  $ (partial f)/(partial x)(x, y) = lim_(h -> 0) (f(x + h, y) - f(x, y)) / h $
  と書く。$y$ についても同様に定める。
]

本書で使う二変数の2次関数は次の形に帰着させられる。

#lemma[
  $a > 0$ かつ $a c - b^2 > 0$ とし
  $ f(x, y) = a x^2 + 2 b x y + c y^2 $
  とする。このとき任意の $(x, y) != (0, 0)$ に対して $f(x, y) > 0$ であり、$f(0, 0) = 0$ である。特に $f$ は原点で最小値 $0$ をとる。
]<lem-quad2>

=== 制約付きの最小化とラグランジュの未定乗数法

制約付きの最小化については、本書では代入法を基本とする。制約 $x + y = 1$ のもとで $y$ を消去し、一変数の2次関数として @eq-quad-min を適用する。この方法は制約を等式で表せる場合に常に使え、しかも解を見つける過程がそのまま証明になる。

多数の資産を一度に扱う第 5 章に備えて、同じ問題を連立方程式の形に書き換える方法を導入する。制約 $g(bold(w)) = 0$ の下での $f(bold(w))$ の最小化において、新しい変数 $lambda$ を導入して
$ L(bold(w), lambda) = f(bold(w)) - lambda g(bold(w)) $
#par(first-line-indent: (amount: 0pt))[を作り、$L$ の各変数についての偏微分係数を $0$ とおく。得られた方程式系の解が最小点の候補になる。]この方法を#term-meta((kana: "らぐらんじゅのみていじょうすうほう", ja: "ラグランジュの未定乗数法", en: "method of Lagrange multipliers"))#strong[ラグランジュの未定乗数法]（method of Lagrange multipliers）と呼ぶ。本書で扱う $f$ は2次関数、$g$ は線形関数であるため、この手続きは代入法と同じ解を与える。このことは第 5 章の定理の証明の中で確認される。

== 記号のまとめ

本章で導入した記号を整理する。$Sigma$ は和、$bold(v)$ はベクトル、$bold(v)^T bold(w)$ は内積、$bold(S)$ は正方行列、$bold(I)$ は単位行列、$bold(S)^(-1)$ は逆行列である。重みとは和が $1$ の実数の組であり、重み付き平均は $sum w_i a_i$ である。2次関数の最小値は平方完成により求め、制約があるときは制約式で一つの変数を消去してから同じ手順を踏む。変数が多いときはラグランジュの未定乗数法で連立方程式の形に書き換える。
