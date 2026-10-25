#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta
#import "@preview/cetz:0.5.2"

= 効率とシャープレシオ

前章では、リスク資産だけからなるポートフォリオの分散を最小にする重みを求めた。しかし投資家の関心は、期待収益率をできるだけ高くすることと、リスクをできるだけ小さくすることの、二つの間の兼ね合いにある。この章では安全資産を分析に加え、期待収益率とリスクの兼ね合いを一つの数で測る指標としてシャープレシオを導入する。そして、シャープレシオを最大化するポートフォリオの重みを求め、シャープレシオが効率の指標として選ばれる理由を論じる。さらに、長期の複利成長率とシャープレシオの関係を明らかにし、到達可能な投資成果の全体を効率的フロンティアとして整理する。

== 安全資産との組み合わせ

リスク資産だけで作った一つのポートフォリオ $p$ を選び、残りの資金を安全資産に置く投資を考える。ポートフォリオ $p$ の期待収益率を $mu_p$、標準偏差を $sigma_p$ とする。総資金のうち $w$ を $p$ に、$1 - w$ を安全資産に配分するとき、この投資全体の収益率は $R = (1 - w) r_f + w R_p$ である。期待収益率と標準偏差を計算すると、次の定理が成り立つ。

#theorem[
  $w >= 0$ のとき、組み合わせの期待収益率 $mu$ と標準偏差 $sigma$ は
  $ mu = r_f + (sigma / sigma_p) (mu_p - r_f) $ <eq-cml>
  を満たす。すなわち、点 $(sigma, mu)$ は $sigma$-$mu$ 平面上で、点 $(0, r_f)$ と点 $(sigma_p, mu_p)$ を結ぶ直線上にある。
]<thm-cml>

#proof[
  期待収益率について、@thm-portfolio-mean の証明と同じ計算により
  $ mu = E[(1 - w) r_f + w R_p] = (1 - w) r_f + w mu_p = r_f + w (mu_p - r_f) $
  である。分散について、@thm-var-sum を $a = w$、$b = 1 - w$ として適用すると
  $ V[R] = w^2 V[R_p] + (1 - w)^2 dot.c 0 + 2 w (1 - w) dot.c "Cov"[R_p, r_f] $
  安全資産の収益率は確率 $1$ で定数 $r_f$ であり、定数と確率変数の共分散は $0$ である。実際、$"Cov"[R_p, r_f] = E[(R_p - mu_p)(r_f - r_f)] = 0$ である。よって $V[R] = w^2 sigma_p^2$ であり、$w >= 0$ のとき $sigma = w sigma_p$ である。この $w = sigma \/ sigma_p$ を $mu$ の式に代入すると主張の等式が得られる。
]

#corollary[
  $w >= 0$ のとき、組み合わせの標準偏差は配分 $w$ の関数として
  $ sigma = f(w) = w sigma_p $
  と表せる。$f$ は $w = 0$ で $0$、$w$ の増加に伴い増えるので、$w$ を $0$ から大きくするにつれて、目標とするどのリスク水準 $sigma >= 0$ もちょうど実現できる。
]<cor-sigma-w>

この定理の意味するところは大きい。リスク資産ポートフォリオ $p$ を一つ決めれば、@cor-sigma-w の関係 $sigma = w sigma_p$ に従って安全資産との配分 $w$ を動かすことで、リスクの水準 $sigma$ を $0$ から自由に調整できる。しかも、調整後の $(sigma, mu)$ は原点近くの点 $(0, r_f)$ から $(sigma_p, mu_p)$ への直線上を動く（@fig-cal）。リスクをどう設定するかは、この直線の上でどこを取るかということになる。

#figure(
  cetz.canvas(length: 0.3cm, {
    import cetz.draw: *
    let rf = 2
    let sp = 20
    let mp = 8
    line((0, 0), (30, 0), stroke: 0.7pt + black)
    line((0, 0), (0, 11), stroke: 0.7pt + black)
    content((30, -0.7), [$sigma$], anchor: "north-east")
    content((0, 11.4), [$mu$], anchor: "south")
    // capital allocation line, extended a bit beyond
    let slope = (mp - rf) / sp
    line((-2, rf - 2 * slope), (28, rf + 28 * slope), stroke: 0.9pt + black)
    circle((0, rf), radius: 0.22, fill: black)
    circle((sp, mp), radius: 0.22, fill: black)
    line((sp, 0), (sp, mp), stroke: 0.4pt + gray, dash: "dotted")
    line((0, mp), (sp, mp), stroke: 0.4pt + gray, dash: "dotted")
    line((0, rf), (0, 0), stroke: 0.4pt + gray, dash: "dotted")
    content((-0.8, rf), [$r_f$], anchor: "east")
    content((-1.0, 2.9), [安全資産], anchor: "south-east")
    line((-0.9, 2.85), (-0.22, 2.25), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((sp, -0.8), [$sigma_p$], anchor: "north")
    content((-1.5, mp), [$mu_p$], anchor: "east")
    content((5.5, 3.0), [傾き $= (mu_p - r_f)\/sigma_p = S_p$], anchor: "north-west")
    line((10.5, 3.15), (10.5, rf + 10.5 * slope - 0.15), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((17.9, 9.5), [ポートフォリオ $p$], anchor: "east")
    line((18.05, 9.5), (20.05, 8.2), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
  }),
  caption: [安全資産とポートフォリオ $p$ の組み合わせは $sigma$-$mu$ 平面上の直線上を動く],
  supplement: [図],
)<fig-cal>

$w > 1$、すなわち安全資産を担保に借り入れてリスク資産に投じる場合も同じ直線が $sigma_p$ より右へ延びるだけで、@thm-cml の関係式はそのまま成り立つ。$w < 0$ では $sigma = w sigma_p$ が負にならないよう絶対値を取る必要があるが、以下の議論に影響しないため、本書では $w >= 0$ を扱う。

== シャープレシオ

ポートフォリオ $p$ について、@thm-cml の直線の傾きは $(mu_p - r_f)\/sigma_p$ である。この量に名前を付ける。

#definition[
  ポートフォリオ $p$ の#term-meta((kana: "しゃーぷれしお", ja: "シャープレシオ", en: "Sharpe ratio"))#strong[シャープレシオ]（Sharpe ratio）を
  $ S_p = (mu_p - r_f) / sigma_p $ <eq-sharpe-def>
  と定める。分子の $mu_p - r_f$ を#term-meta((kana: "ちょうかしゅうえきりつ", ja: "超過収益率", en: "excess return"))#strong[超過収益率]（excess return）と呼ぶ。
]

シャープレシオは、安全資産の収益率を上回る部分、すなわちリスクを負って稼ぐ部分を、負ったリスクの大きさで割ったものである。リスク単位あたりの報酬と解釈できる。この指標はシャープがファンドの成績評価のために導入したものであり @sharpe1966、その後の整理 @sharpe1994 を経て、投資の効率を測る標準的な指標になった。

シャープレシオが高いポートフォリオほど、@thm-cml の直線は急になる。次の定理はこの急さがそのまま投資家の到達点の高さを決めることを示す。

#theorem[
  （最大シャープレシオの効率性）$p^*$ をリスク資産だけで作れるポートフォリオの中でシャープレシオが最大のものとし、そのシャープレシオを $S^*$ とする。このとき、安全資産とリスク資産の任意の組み合わせで到達できる期待収益率 $mu$ と標準偏差 $sigma > 0$ に対して
  $ mu <= r_f + S^* sigma $ <eq-sharpe-bound>
  が成り立つ。等号はリスク資産の部分に $p^*$ を使ったときに限って実現される。
]<thm-sharpe-bound>

#proof[
  安全資産とリスク資産ポートフォリオ $p$ の組み合わせを取る。@thm-cml より、到達点は
  $ mu = r_f + (mu_p - r_f) (sigma / sigma_p) = r_f + S_p sigma $
  と表せる。この式は $sigma = 0$ のとき両辺とも $r_f$ なので正しい。$S_p$ は $p^*$ の選定より $S_p <= S^*$ であり、$sigma >= 0$ だから両辺に $sigma$ を掛けても不等号は保たれる。よって任意の $sigma >= 0$ に対して $mu <= r_f + S^* sigma$ が成り立つ。等号には $S_p = S^*$ が必要であり、これは $p$ が最大シャープレシオを持つことと同値である。
]

この定理により、投資家がどのリスク水準を目指すにせよ、リスク資産の部分に選ぶべきはシャープレシオ最大のポートフォリオ $p^*$ である。リスクの水準の調整は安全資産との配分で後からいくらでもできるため、選ぶべきリスク資産ポートフォリオはリスク水準によらず一つに定まる。この性質をのちの章で分離定理として用いる。

== 最大シャープレシオのポートフォリオ

資産 $i$ の超過収益率の期待値 $mu_i - r_f$ を成分とするベクトルを
$ tilde(bold(mu)) = (mu_1 - r_f, ..., mu_n - r_f)^T $
と書く。すべての資産の期待収益率が $r_f$ に等しい場合、リスクを負う理由がなく分析は自明になる。そこで以下、$tilde(bold(mu)) != bold(0)$ と仮定する。

#theorem[
  （最大シャープレシオのポートフォリオ）$bold(Sigma)$ を正定値な分散共分散行列とし、$bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)) > 0$ とする。このとき、リスク資産ポートフォリオの中でシャープレシオを最大化する重みは
  $ bold(w)^"*" = (bold(Sigma)^(-1) tilde(bold(mu))) / (bold(1)^T bold(Sigma)^(-1) tilde(bold(mu))) $ <eq-tangency>
  であり、最大のシャープレシオは
  $ S^* = sqrt(tilde(bold(mu))^T bold(Sigma)^(-1) tilde(bold(mu))) $ <eq-max-sharpe>
  である。この $bold(w)^"*"$ を#term-meta((kana: "せってんぽーとふぉりお", ja: "接点ポートフォリオ", en: "tangency portfolio"))#strong[接点ポートフォリオ]（tangency portfolio）と呼ぶ。
]<thm-tangency>

#proof[
  任意の重み $bold(w)$ に対するシャープレシオを書き換える。$tilde(bold(mu)) = bold(Sigma) bold(Sigma)^(-1) tilde(bold(mu))$ なので、内積の対称性を使うと
  $ tilde(bold(mu))^T bold(w) = (bold(Sigma)^(-1) tilde(bold(mu)))^T bold(Sigma) bold(w) $
  である。実際、右辺を成分で書くと $sum_i sum_j (bold(Sigma)^(-1) tilde(bold(mu)))_i sigma_(i j) w_j$ であり、$bold(Sigma) bold(Sigma)^(-1) tilde(bold(mu)) = tilde(bold(mu))$ と対称性から、この和は $sum_j tilde(bold(mu))_j w_j$ に一致する。そこで $bold(u) = bold(Sigma)^(-1) tilde(bold(mu))$、$bold(v) = bold(Sigma) bold(w)$ として @eq-cs-weighted を適用する。このとき $bold(u)^T bold(v) = tilde(bold(mu))^T bold(w)$ であり、$bold(u)^T bold(Sigma) bold(u) = tilde(bold(mu))^T bold(Sigma)^(-1) tilde(bold(mu))$、$bold(v)^T bold(Sigma)^(-1) bold(v) = bold(w)^T bold(Sigma) bold(Sigma)^(-1) bold(Sigma) bold(w) = bold(w)^T bold(Sigma) bold(w)$ である。よって
  $ (tilde(bold(mu))^T bold(w))^2 <= (tilde(bold(mu))^T bold(Sigma)^(-1) tilde(bold(mu))) (bold(w)^T bold(Sigma) bold(w)) $
  両辺を正の数 $bold(w)^T bold(Sigma) bold(w)$ で割ったのち、正の平方根をとると
  $ (tilde(bold(mu))^T bold(w)) / sqrt(bold(w)^T bold(Sigma) bold(w)) <= sqrt(tilde(bold(mu))^T bold(Sigma)^(-1) tilde(bold(mu))) $
  左辺の分子は $tilde(bold(mu))^T bold(w) = sum_(i=1)^n w_i (mu_i - r_f) = mu_p - r_f$ である。分母は、@thm-var-general がポートフォリオの分散を $V[R_p] = bold(w)^T bold(Sigma) bold(w)$ と表しているので、$sqrt(bold(w)^T bold(Sigma) bold(w)) = sqrt(V[R_p]) = sigma_p$ である。したがって任意のポートフォリオのシャープレシオは $sqrt(tilde(bold(mu))^T bold(Sigma)^(-1) tilde(bold(mu)))$ 以下である。

  この上界が達成されることを確認する。@lem-cs-weighted の等号条件 $bold(v) = c bold(Sigma) bold(u)$ に $bold(u) = bold(Sigma)^(-1) tilde(bold(mu))$、$bold(v) = bold(Sigma) bold(w)$ を代入すると $bold(Sigma) bold(w) = c tilde(bold(mu))$、すなわち $bold(w) = c bold(Sigma)^(-1) tilde(bold(mu))$ である。予算制約 $bold(1)^T bold(w) = 1$ を満たすように $c = 1\/(bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)))$ と選べば @eq-tangency の重みが得られる。仮定 $bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)) > 0$ により $c > 0$ であり、達成可能である。最大値は上界に等しいから @eq-max-sharpe が成り立つ。
]

仮定 $bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)) > 0$ について触れておく。この条件は、@eq-tangency の分母、すなわち $bold(Sigma)^(-1) tilde(bold(mu))$ の成分の総和が正であることを課す。超過収益率のベクトルと分散の構造が特定の歪み方をしない限り満たされる。条件が満たされない場合、シャープレシオの上限は安全資産の側から漸近的に近づくのみで、最大を与える重みが予算制約の下で存在しない。これは理論上の特殊ケースであり、通常の市場データでは起こらない。

#example[
  二資産で分散が等しく $sigma_1 = sigma_2 = sigma$、相関係数が $rho$、超過収益率が $mu_1 - r_f = 0.06$、$mu_2 - r_f = 0.02$ とする。$sigma = 0.2$、$rho = 0.3$ のとき、共分散は $sigma_(1 2) = 0.3 dot.c 0.04 = 0.012$ である。@eq-tangency の計算（行列の逆行列は2次の連立方程式を解くことに等しい）により接点ポートフォリオの重みは $w_1^* = 27\/28 tilde.op 0.96$、$w_2^* = 1\/28 tilde.op 0.04$ となる。期待収益率の高い資産 1 に傾きつつも、資産 2 も保有して分散を下げる構成が最適になっている。
]<ex-tangency>

== なぜシャープレシオが効率の指標なのか

投資の優劣を測る指標はシャープレシオだけではない。この節では、シャープレシオを選ぶ理由を三つの観点から整理する。

=== 理由の一つ目：到達可能な投資成果の上限を定める

第一の観点は @thm-sharpe-bound そのものである。安全資産をいくらでも貸し借りできる環境では、投資家が到達できる期待収益率は $mu <= r_f + S^* sigma$ で上から抑えられる。目標とするリスク水準 $sigma$ が何であれ、到達点の高さを決めるのは最大シャープレシオ $S^*$ だけである。投資家ごとにリスク許容度が違っても、効率の比較軸として意味を持つのはシャープレシオであり、期待収益率や標準偏差そのものではない。

=== 理由の二つ目：長期の成長率を最大化する

第二の観点は複利で資産を伸ばす長期投資の成長率との関係である。投資家が資産を一期間ごとに再投資して複利で伸ばすとき、長期的な成長率を左右するのは、一期間の収益率の期待値ではなく、$log(1 + R)$ の期待値である。次節で詳しく論じる通り、この期待値を最大化すれば、長期の成長率を決めるのはシャープレシオの2乗であり、期待収益率そのものではない。どのリスク水準を目指す場合にも、選ぶべきリスク資産ポートフォリオはシャープレシオ最大のものに一本化される。

=== 理由の三つ目：実務での比較基準としての役割

第三の観点は実務上のものである。シャープは @sharpe1966 で、ファンドの成績を評価する指標として超過収益率を標準偏差で割る量を提案し、@sharpe1994 でその解釈と適用範囲を整理した。この指標が実務で広く使われる理由は、本節の前二つの観点と対応している。すなわち、安全資産との組み合わせでリスク水準を調整できる投資家にとって、比較すべきはリスク単位あたりの報酬であり、また長期の複利成長を左右するのもシャープレシオだからである。期待収益率だけを比べればリスクの大きい投資が有利と見え、標準偏差だけを比べればリスクの小さい投資が有利と見える。シャープレシオはこの二つを一つの軸に統合する。

== 長期の成長率の最大化

前節の第二の観点として挙げた、複利で資産を伸ばす長期投資の成長率との関係を、この節で詳しく論じる。投資家が資産を一期間ごとに再投資して複利で伸ばすとき、長期的な成長率を左右するのは、一期間の収益率の期待値ではなく、$log(1 + R)$ の期待値である。これは次のようにして分かる。初期資産を $1$ とし、各期の収益率の実現値を $R_1, ..., R_m$ とすると、$m$ 期後の資産は $(1 + R_1)(1 + R_2) dots.c (1 + R_m)$ である。対数をとると積は和に変わるので、$m$ 期後の資産の対数は $sum_(t=1)^m log(1 + R_t)$ であり、一期間あたりの対数成長率はこれを $m$ で割った $(1\/m) sum_(t=1)^m log(1 + R_t)$ である。各期の収益率が独立同分布に従うなら $log(1 + R_t)$ も独立同分布に従うので、@rem-lln により、この平均は $m$ を大きくするにつれて $log(1 + R)$ の期待値に近づく。したがって複利を重ねた長期の成長率は、$log(1 + R)$ の期待値で決まる。

#theorem[
  ポートフォリオ $p$ と安全資産の配分 $w$ を選ぶ投資家の期待対数成長率
  $ g(w) = E[log(1 + r_f + w (R_p - r_f))] $
  を、$log(1 + x) tilde.op x - x^2\/2$ の近似のもとで $w$ について最大化すると、最適配分は $w^* = (mu_p - r_f)\/sigma_p^2$ であり、最大化された成長率は
  $ g(w^*) tilde.op r_f + S_p^2 \/ 2 $ <eq-growth>
  である。
]<thm-growth>

#proof[
  近似 $log(1 + x) tilde.op x - x^2\/2$ を $x = r_f + w (R_p - r_f)$ に適用すると
  $ g(w) tilde.op E[r_f + w (R_p - r_f)] - (1\/2) E[(r_f + w (R_p - r_f))^2] $
  第一項は $r_f + w (mu_p - r_f)$ である。第二項の期待値を展開すると
  $ E[(r_f + w (R_p - r_f))^2] = (r_f + w(mu_p - r_f))^2 + w^2 sigma_p^2 $
  である。よって
  $ g(w) tilde.op r_f + w (mu_p - r_f) - (w^2\/2) sigma_p^2 $
  これは $w$ の2次関数で、$w^2$ の係数は負であるから、@eq-quad-min と同じ計算により $w = (mu_p - r_f)\/sigma_p^2$ で最大になる。最大値を代入すると
  $ g(w^*) tilde.op r_f + (mu_p - r_f)^2\/(2 sigma_p^2) = r_f + S_p^2\/2 $
  である。
]

@thm-growth の証明で得た2次式は、成長率の内訳を示している。組み合わせの期待収益率は $mu(w) = r_f + w (mu_p - r_f)$ と $w$ について線形であり、$w$ を大きくするほど際限なく増える。ところが成長率の式では、そこからさらに $w^2 sigma_p^2 \/ 2$ が差し引かれる。複利では実現したマイナスの収益率が翌期の元本を削るため、収益率のばらつきそのものが長期的な成長率を削る。この削られた分を#term-meta((kana: "ぼらてぃりてぃ・どらっぐ", ja: "ボラティリティ・ドラッグ", en: "volatility drag"))#strong[ボラティリティ・ドラッグ]（volatility drag）と呼ぶ。$w$ を大きくすると、期待収益率の増え方は線形にとどまる一方、ボラティリティ・ドラッグは $w$ の2乗で増える。したがってあるところで後者の増え方が前者を上回り、$g(w)$ は有限の $w^*$ で最大になる。期待収益率だけを基準にレバレッジを強める投資家は、長期の成長率という基準では $w^*$ を超えた分だけ損をすることになる。なお、成長率が有限の $w$ で最大になること自体は2次近似の副産物ではない。$log$ が凹関数（@def-concave）であることから、近似を使わない $g(w)$ も $w$ について凹であり、有限の最大点を持つ。$w$ を大きくしすぎて正の確率で元本を全額失う状態が現れれば $log(1 + R)$ は定義できず、期待対数成長率は $-oo$ に落ちる。

一期間あたりの平均的な複利収益率、すなわち $exp(g(w)) - 1$ を#term-meta((kana: "きかへいきんしゅうえきりつ", ja: "幾何平均収益率", en: "geometric mean return"))#strong[幾何平均収益率]（geometric mean return）と呼ぶ。@thm-growth の近似の下では $exp(g(w)) - 1 tilde.op mu(w) - (w^2 sigma_p^2)\/2$ であり、一期間の収益率の期待値からボラティリティ・ドラッグを引いた値になる。長期の再投資で手にするのは幾何平均収益率の方であり、一期間の収益率の期待値ではない。

#corollary[
  （リスク目標を固定した成長率）ポートフォリオ $p$ の標準偏差を $sigma_p > 0$ とし、投資家が組み合わせの標準偏差が目標値 $sigma >= 0$ となるように配分 $w = sigma\/sigma_p$ を選ぶとき、期待対数成長率は
  $ g tilde.op r_f + sigma S_p - sigma^2 \/ 2 $ <eq-growth-sigma>
  となる。したがって、任意のリスク水準 $sigma > 0$ を目標とする投資家にとって、期待対数成長率は $S_p$ が高いポートフォリオほど高い。
]<cor-growth-sigma>

#proof[
  @cor-sigma-w より、目標値 $sigma$ は配分 $w = sigma\/sigma_p$ で実現できる。@thm-growth の証明で得た $g(w) tilde.op r_f + w (mu_p - r_f) - (w^2\/2) sigma_p^2$ にこの $w$ を代入すると
  $ g tilde.op r_f + (sigma\/sigma_p) (mu_p - r_f) - (sigma^2\/(2 sigma_p^2)) sigma_p^2 = r_f + sigma S_p - sigma^2\/2 $
  となる。右辺の $r_f$ と $sigma^2\/2$ の項はポートフォリオによらないので、$sigma > 0$ を固定すれば $g$ は $S_p$ について単調に増加する。
]

@thm-growth と @cor-growth-sigma は重要な含意を持つ。長期の成長率を決めるのはシャープレシオの2乗であり、期待収益率そのものではない。期待対数成長率を最大にするには、リスク資産ポートフォリオ $p$ の選択と配分 $w$ の選択という二段階がともに必要である。第一段階の $p$ の選択では、@thm-growth より、配分 $w$ まで最適化した成長率は $r_f + S_p^2\/2$ であり、これはシャープレシオのみで決まる。また @cor-growth-sigma より、どのリスク水準を目指す場合にも、成長率は $S_p$ が高いポートフォリオほど高い。同じリスクを取る二つのポートフォリオを比べれば、成長率が高いのは期待収益率が高い方ではなく、シャープレシオが高い方である。したがってここでも、選ぶべき $p$ は投資家のリスク許容度によらずシャープレシオ最大のものに一本化される。第二段階の配分 $w$ の選択、すなわちリスク水準 $sigma = w sigma_p$ の決定は、投資家が各自のリスク許容度に応じて行う。ここに選好の個人性が現れる。成長率のみを目的とする投資家は、@eq-growth-sigma の右辺を $sigma$ について最大にする $sigma^* = S_p$ にリスク水準を選ぶ。第一段階で $p$ をシャープレシオ最大のものに選んでいれば $S_p = S^*$ であるから、成長率は最大値 $r_f + S^(*2)\/2$ に達する。

#remark[
  期待対数成長率を最大化するという投資基準は、#term-meta((kana: "けりーきじゅん", ja: "ケリー基準", en: "Kelly criterion"))#strong[ケリー基準]（Kelly criterion）として知られる。ケリーは @kelly1956 で、繰り返し賭けを行う場面で富の対数の期待値を最大にする配分が、長期的な富の成長率を最大にすることを示した。@thm-growth の最適配分 $w^* = (mu_p - r_f)\/sigma_p^2$ は、この基準を安全資産とポートフォリオ $p$ の配分に適用したものに相当する。ただし本書の導出は2次近似に基づくため、@thm-growth の結果はケリー基準の平均・分散による近似として解釈される。
]

この議論で使った近似は収益率が平均の周りに大きくばらけない場合に精度が良い。収益率の分散が大きい場合や破産の可能性がある場合には近似の精度が落ちるため、結果は近似的なものとして解釈される。

#example[
  @ex-tangency の二資産（$sigma_1 = sigma_2 = 0.2$、$rho = 0.3$）に安全資産金利 $r_f = 0.02$ を加える。接点ポートフォリオの超過収益率は $mu_p - r_f tilde.op 0.059$、分散は $sigma_p^2 tilde.op 0.038$、シャープレシオは $S^* tilde.op 0.30$ である。@thm-growth の最適配分は $w^* = (mu_p - r_f)\/sigma_p^2 tilde.op 1.54$ となる。$w^* > 1$ であるから、成長率のみを目的とする投資家は安全資産を担保に借り入れて、自己資金の約 $1.54$ 倍を接点ポートフォリオに投じる。このときの成長率は $r_f + S^(*2)\/2 tilde.op 0.065$ であり、借り入れを使わない $w = 1$ の成長率 $r_f + (mu_p - r_f) - sigma_p^2\/2 tilde.op 0.060$ を上回る。期待収益率だけを見れば $w = 1$ で $0.079$、$w = w^*$ で $0.110$ と増え続けるが、差し引かれるボラティリティ・ドラッグが $0.019$ から $0.045$ へ増えるため、成長率は $w^*$ を超えると下がる。また、リスク目標 $sigma$ を固定した投資家の成長率は @cor-growth-sigma より $r_f + sigma S^* - sigma^2\/2$ である。$sigma = 0.10$ なら $tilde.op 0.045$、$sigma = sigma_p tilde.op 0.195$ なら $tilde.op 0.060$ となる。この式の最大点は $sigma^* = S^* tilde.op 0.30$ であり、対応する配分 $sigma^*\/sigma_p tilde.op 1.54$ は @thm-growth の $w^*$ と一致する。
]<ex-growth>

== 効率的フロンティア

これまでの結果を、$sigma$-$mu$ 平面上の図像として整理する。リスク資産だけで作れるポートフォリオ全体の集合を考える。各ポートフォリオは平面上に一点を対応させ、これらの点全体が作る図形を#term-meta((kana: "じっこうかのうしゅうごう", ja: "実行可能集合", en: "feasible set"))#strong[実行可能集合]（feasible set）と呼ぶ。実行可能集合の最左端の点は @thm-minvar-n の最小分散ポートフォリオである。このポートフォリオはすべてのポートフォリオの中で分散が最小であるから、どのポートフォリオの標準偏差もこの点の標準偏差を下回らず、実行可能集合はこの点の右側にのみ広がる。境界はこの点を始点として上側と下側の二本の枝に分かれて右へ延びる。上側の枝は各リスク水準に対して達成可能な最大の期待収益率を、下側の枝は最小の期待収益率を与える。この上側の境界を#term-meta((kana: "こうりつてきふろんてぃあ", ja: "効率的フロンティア", en: "efficient frontier"))#strong[効率的フロンティア]（efficient frontier）と呼ぶ。@fig-frontier はこの様子を表したものである。

#figure(
  cetz.canvas(length: 0.3cm, {
    import cetz.draw: *
    let ctr = (15, 6)
    let rx = 9
    let ry = 4.2
    let ang = 25
    let rot(p, deg) = {
      let t = deg * calc.pi / 180
      let (x, y) = p
      (x * calc.cos(t) - y * calc.sin(t), x * calc.sin(t) + y * calc.cos(t))
    }
    let boundary(theta) = {
      let (x, y) = rot((rx * calc.cos(theta), ry * calc.sin(theta)), ang)
      (x + ctr.at(0), y + ctr.at(1))
    }
    let pts = ()
    let n = 64
    for i in range(0, n + 1) {
      pts.push(boundary(i / n * 2 * calc.pi))
    }
    line(..pts, close: true, fill: luma(235), stroke: none)
    line(..pts, close: true, stroke: 0.5pt + gray)
    line((0, 0), (30, 0), stroke: 0.7pt + black)
    line((0, 0), (0, 12), stroke: 0.7pt + black)
    content((30, -0.7), [$sigma$], anchor: "north-east")
    content((0, 12.4), [$mu$], anchor: "south")
    // the leftmost boundary point is the minimum-variance portfolio
    let best = boundary(0)
    let best-t = 0
    for i in range(0, 200) {
      let t = i / 200 * 2 * calc.pi
      let p = boundary(t)
      if p.at(0) < best.at(0) { best = p; best-t = t }
    }
    // efficient frontier: the upper branch from the minimum-variance portfolio
    let up = ()
    for i in range(0, 65) {
      up.push(boundary(best-t * (1 - i / 64)))
    }
    line(..up, stroke: 1.1pt + black)
    circle(best, radius: 0.22, fill: black)
    content((best.at(0) - 0.3, best.at(1) - 1.0), [最小分散], anchor: "north-east")
    line((best.at(0) - 0.35, best.at(1) - 0.9), (best.at(0) - 0.12, best.at(1) - 0.18), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((22, 13.0), [効率的フロンティア], anchor: "south")
    line((21.8, 12.8), (boundary(0.34).at(0), boundary(0.34).at(1) - 0.15), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    let rf = 2
    let tp = boundary(calc.pi * 0.569)
    circle(tp, radius: 0.22, fill: black)
    let slope = (tp.at(1) - rf) / tp.at(0)
    let line-x = (11.5 - rf) / slope
    line((0, rf), (line-x, 11.5), stroke: 0.9pt + black)
    circle((0, rf), radius: 0.22, fill: black)
    content((-0.8, rf), [$r_f$], anchor: "east")
    content((tp.at(0) + 0.7, tp.at(1) - 1.2), [接点ポートフォリオ], anchor: "north-west")
    line((tp.at(0) + 0.62, tp.at(1) - 1.12), (tp.at(0) + 0.15, tp.at(1) - 0.18), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((line-x + 0.3, 11.9), [最大シャープレシオの直線], anchor: "west")
    line((line-x + 0.2, 11.78), (line-x + 0.02, 11.56), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
  }),
  caption: [実行可能集合、効率的フロンティア、接点ポートフォリオ],
  supplement: [図],
)<fig-frontier>

安全資産が存在する場合、@thm-cml より、投資家の到達可能な点は点 $(0, r_f)$ から実行可能集合の各点へ伸びる直線の上にある。これらの直線の中で最も傾きが大きいものは、接点ポートフォリオ $bold(w)^"*"$ を通る直線であり、その傾きは $S^*$ である。この直線を#term-meta((kana: "しほんしじょうせん", ja: "資本市場線", en: "capital market line"))#strong[資本市場線]（capital market line、CML）と呼ぶ。効率的な投資はすべて、この一本の直線上に乗る。リスク資産のみの効率的フロンティアは、この直線より下に位置し、接点ポートフォリオの点でのみ接する。

投資家の行動はここで二段階に分かれる。第一段階では、すべての投資家が同じ接点ポートフォリオ $bold(w)^"*"$ を選ぶ。これは @thm-sharpe-bound と @cor-growth-sigma が示す通り、リスク許容度によらない。第二段階では、各自のリスク許容度に応じて、接点ポートフォリオと安全資産の配分 $w$ を決める。選好の個人性が現れるのは第二段階だけである。この二段階への分解は次章で市場全体の均衡を分析するときの鍵になる。
