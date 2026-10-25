#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta

= 確率と期待値

資産の収益率は将来の値を現時点で確定できない量であり、連続的な値をとる。この章では、そのような量を扱うための枠組みとして密度関数を持つ確率変数を導入し、期待値、分散、共分散を定義して、本書で繰り返し使う等式を定理と補題の形に整える。証明は付録Bにまとめて述べる。

== 確率変数と密度関数

確率変数の分布は密度関数によって記述する。

#definition[
  実数直線上で定義された関数 $f$ が、すべての $x$ で $f(x) >= 0$ かつ
  $ integral_(-oo)^(oo) f(x) dif x = 1 $
  を満たすとき、$f$ を#term-meta((kana: "みつどかんすう", ja: "密度関数", en: "density function"))#strong[密度関数]（density function）と呼ぶ。
]<def-density>

#definition[
  密度関数 $f$ に#term-meta((kana: "かくりつへんすう", ja: "確率変数", en: "random variable"))#strong[確率変数]（random variable）$X$ が従うとは、任意の実数 $a <= b$ に対して
  $ P(a <= X <= b) = integral_a^b f(x) dif x $ <eq-continuous-prob>
  が成り立つことである。$P(a <= X <= b)$ を $X$ が区間 $[a, b]$ に入る確率と呼ぶ。資産の収益率は確率変数の実例である。
]

#definition[
  二つの確率変数 $X, Y$ の組は、すべての $x, y$ に対して
  $ P(a <= X <= b, c <= Y <= d) = integral_a^b integral_c^d f(x, y) dif x dif y $
  を満たす#term-meta((kana: "どうじみつど", ja: "同時密度", en: "joint density"))#strong[同時密度]（joint density）$f(x, y)$ を持つ。ここで
  $ f_X(x) = integral_(-oo)^(oo) f(x, y) dif y $
  は $X$ 単独の密度関数になっており、同時密度から一方の変数を積分して得られる密度として#term-meta((kana: "しゅうへんみつど", ja: "周辺密度", en: "marginal density"))#strong[周辺密度]（marginal density）と呼ぶ。$Y$ の周辺密度 $f_Y$ も同様に定まる。
]

== 期待値

#definition[
  密度関数 $f$ に従う確率変数 $X$ の#term-meta((kana: "きたいち", ja: "期待値", en: "expected value"))#strong[期待値]（expected value）を
  $ E[X] = integral_(-oo)^(oo) x f(x) dif x $ <eq-continuous-expectation>
  と定める。密度を重みとした $X$ の値の平均である。
]

期待値は確率変数の平均的な値を表す。ただし期待値が等しくても、値のばらつき方は異なりうる。ばらつきを測る分散は次節で定義する。

期待値の計算上の性質を三つ述べる。第一の性質はこの章で最もよく使い、本書の議論の背骨になる。

#theorem[
  確率変数 $X, Y$ と実数 $a, b$ に対して
  $ E[a X + b Y] = a E[X] + b E[Y] $ <eq-linear>
  が成り立つ。#term-meta((kana: "きたいちのせんけいせい", ja: "期待値の線形性", en: "linearity of expectation"))#strong[期待値の線形性]（linearity of expectation）と呼ばれる。
]<thm-linear>

#corollary[
  確率変数 $X$ と実数 $c$ に対して $E[c] = c$ が成り立つ。
]<cor-const>

#lemma[
  確率変数 $X, Y$ が $X <= Y$ を満たすならば $E[X] <= E[Y]$ である。
]

== 分散と標準偏差

期待値だけでは、確率変数の値が期待値の周りにどの程度集中しているかは分からない。集中の度合いを測る量が分散である。

#definition[
  確率変数 $X$ の#term-meta((kana: "ぶんさん", ja: "分散", en: "variance"))#strong[分散]（variance）を
  $ V[X] = E[(X - E[X])^2] $
  と定め、その平方根 $sqrt(V[X])$ を#term-meta((kana: "ひょうじゅんへんさ", ja: "標準偏差", en: "standard deviation"))#strong[標準偏差]（standard deviation）と呼ぶ。
]

分散は、$X$ の期待値からの隔たり $X - E[X]$ の2乗の期待値である。2乗するため、上への隔たりも下への隔たりも正の寄与を持つ。標準偏差は分散と同じ情報を、$X$ と同じ単位で表したものである。第 5 章以降では、標準偏差が投資におけるリスクの尺度として使われる。

#lemma[
  分散は $V[X] = E[X^2] - (E[X])^2$ と書き直せる。
]<lem-var-alt>

#corollary[
  実数 $a, b$ と確率変数 $X$ に対して $V[a X + b] = a^2 V[X]$ が成り立つ。
]<cor-var-affine>

分散が $0$ である確率変数は、確率 $1$ で期待値に等しい。この事実を補題として述べておく。

#lemma[
  $V[X] = 0$ ならば、$P(X = E[X]) = 1$ である。
]<lem-degenerate>

== 共分散と相関係数

=== 共分散

二つの確率変数が同時に動く傾向の強さを測る量が共分散である。ポートフォリオの分散の計算に不可欠な量である。

#definition[
  確率変数 $X, Y$ の#term-meta((kana: "きょうぶんさん", ja: "共分散", en: "covariance"))#strong[共分散]（covariance）を
  $ "Cov"[X, Y] = E[(X - E[X])(Y - E[Y])] $
  と定める。
]

#lemma[
  $ "Cov"[X, Y] = E[X Y] - E[X] E[Y] $ <eq-cov-alt>
  が成り立つ。
]<lem-cov-alt>

$X = Y$ のとき、共分散の定義は分散そのものに一致する。すなわち $"Cov"[X, X] = V[X]$ である。

共分散は第二の引数を固定すると和と実数倍について線形である。のちの章の証明で使うため、補題の形に残しておく。

#lemma[
  確率変数 $X, Y_1, ..., Y_n$ と実数 $a_1, ..., a_n$ に対して
  $ "Cov"[X, sum_(j=1)^n a_j Y_j] = sum_(j=1)^n a_j "Cov"[X, Y_j] $ <eq-cov-linear>
  が成り立つ。
]<lem-cov-linear>

=== 分散の加法性

二つの確率変数の和の分散は各分散と共分散で表せる。この結果が分散投資の利益を計算する出発点になる。

#theorem[
  実数 $a, b$ と確率変数 $X, Y$ に対して
  $ V[a X + b Y] = a^2 V[X] + 2 a b "Cov"[X, Y] + b^2 V[Y] $ <eq-var-sum>
  が成り立つ。
]<thm-var-sum>

この定理に現れる共分散の項を、#term-meta((kana: "そうさようのこう", ja: "相互作用の項", en: "interaction term"))#strong[相互作用の項]（interaction term）と呼ぶことがある。二つの資産が逆に動く傾向、すなわち負の共分散を持つとき、この項は分散を減らす方向に働く。分散投資の利益の源泉はこの項である。第 5 章でこの計算をポートフォリオに適用する。

=== コーシー・シュワルツの不等式

共分散の大きさは二つの標準偏差の積を超えない。この上界がのちに相関係数を $-1$ 以上 $1$ 以下の量として定義する根拠になる。

#theorem[
  （確率変数に対するコーシー・シュワルツの不等式）確率変数 $X, Y$ に対して
  $ ("Cov"[X, Y])^2 <= V[X] V[Y] $ <eq-cauchy>
  が成り立つ。単に#term-meta((kana: "こーしーしゅわるつのふとうしき", ja: "コーシー・シュワルツの不等式", en: "Cauchy-Schwarz inequality"))#strong[コーシー・シュワルツの不等式]（Cauchy–Schwarz inequality）と呼ぶ。
]<thm-cs>

#corollary[
  $V[X] > 0$ かつ $V[Y] > 0$ のとき
  $ rho_(X Y) = ("Cov"[X, Y]) / (sqrt(V[X]) sqrt(V[Y])) $
  と定めると、$-1 <= rho_(X Y) <= 1$ が成り立つ。$rho_(X Y)$ を $X$ と $Y$ の#term-meta((kana: "そうかんけいすう", ja: "相関係数", en: "correlation coefficient"))#strong[相関係数]（correlation coefficient）と呼ぶ。
]

相関係数は二つの確率変数の動き方の関係を、それぞれの標準偏差で基準化した量である。$rho_(X Y)$ が $1$ に近いとき二つは同じ方向へ強く連動し、$-1$ に近いときは逆方向へ強く連動する。$0$ のとき無相関と呼ぶ。ポートフォリオの分散を決めるのは、個々の資産の分散と、資産の間の相関係数である。第 5 章でこの関係を精確に扱う。

== 収益率の確率モデル

本書で確率変数として扱うのは、資産の収益率である。この章の結果の証明が使っているのは、積分の線形性と積分の順序の入れ替えだけである。したがって、期待値や分散が有限に定まる限り、これらの等式は密度関数の形にかかわらず成り立つ。

=== 正規分布

実数の連続的な値をとる分布の代表として、正規分布を導入する。

#definition[
  実数 $mu$ と $sigma > 0$ に対して、密度関数
  $ f(x) = 1 / (sqrt(2 pi) sigma) e^(- (x - mu)^2 / (2 sigma^2)) $ <eq-normal>
  を持つ分布を#term-meta((kana: "せいきぶんぷ", ja: "正規分布", en: "normal distribution"))#strong[正規分布]（normal distribution）と呼び、$N(mu, sigma^2)$ と書く。
]<def-normal>

正規分布の期待値は $mu$、分散は $sigma^2$ であり、分布の形はこの二つの量だけで完全に決まる。したがって、$X$ が正規分布に従うなら、任意の関数 $g$ の期待値 $E[g(X)]$ は $mu$ と $sigma$ のみに依存する。$E[g(X)]$ は密度関数を使った積分
$ E[g(X)] = integral_(-oo)^(oo) g(x) f(x) dif x $
で計算され、$f$ が $mu$ と $sigma$ で決まるためである。正規分布の期待値と分散、および任意の関数の期待値が $mu$ と $sigma$ だけで決まることの証明は、付録Bで与える。

=== 独立と大数の法則

確率変数の独立性を、同時密度を使って定義する。

#definition[
  すべての実数 $x, y$ に対して同時密度が周辺密度の積
  $ f(x, y) = f_X(x) f_Y(y) $ <eq-independent>
  と書けるとき、確率変数 $X$ と $Y$ は#term-meta((kana: "どくりつ", ja: "独立", en: "independent"))#strong[独立]（independent）であると言う。すべての実数 $x$ に対して $f_X(x) = f_Y(x)$ が成り立つとき、$X$ と $Y$ は同一の分布に従うと言う。確率変数 $X_1, X_2, ...$ がどの二つも独立であり、同一の分布に従うとき、これらは#term-meta((kana: "どくりつどうぶんぷ", ja: "独立同分布", en: "independent and identically distributed"))#strong[独立同分布]（independent and identically distributed）に従うと言う。
]<def-independent>

#remark[
  （大数の法則）独立同分布に従う確率変数 $X_1, X_2, ...$ の共通の期待値が有限の値 $mu$ に等しいとき、最初の $m$ 個の平均
  $ (1\/m) sum_(t=1)^m X_t $
  は $m$ を大きくするにつれて $mu$ に近づく。この事実は#term-meta((kana: "たいすうのほうそく", ja: "大数の法則", en: "law of large numbers"))#strong[大数の法則]（law of large numbers）として知られ、証明は本書の範囲を超えるため、結果のみを用いる。
]<rem-lln>

=== 中心極限定理と収益率の正規近似

#remark[
  （中心極限定理）独立同分布に従い分散が有限である確率変数を多数足し合わせた平均値の分布は、個々の分布の形にかかわらず正規分布に近づく。この事実は#term-meta((kana: "ちゅうしんてききょくげんていり", ja: "中心的極限定理", en: "central limit theorem"))#strong[中心的極限定理]（central limit theorem）として知られ、証明は本書の範囲を超えるため、結果のみを用いる。
]<rem-clt>

収益率の分布を正規分布で近似することは、次のような考え方で正当化される。銘柄の収益率は、個々の企業を取り巻く需要の変動、業界のニュース、マクロ経済の状態、個別の経営判断など、多数の要因の合計として決まると考えられる。@rem-clt によれば、各要因の収益率への寄与が独立で小さいなら、収益率の分布は正規分布で近似できることになる。この議論は、要因の独立性や同一性が完全には成り立たない実際の市場では近似にすぎない。特に、収益率の分布の裾は正規分布よりも重く、大きな下落が正規分布の予測より高頻度で現れることが実証研究で知られている。それでも、短期の収益率の分布としては正規分布近似がファイナンスの標準的な出発点であり @bodie2021、本書でもこの立場を探る材料として用いる。
