#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta

= ポートフォリオの収益率と分散

複数の資産に資金を配分した持ち方をポートフォリオと呼ぶ。この章では、ポートフォリオの収益率が、資産ごとの収益率とその配分比率でどのように表されるかを厳密に定式化する。そして、資産の間の相関がポートフォリオの分散を削減する仕組みを定理の形で示し、分散を最小にする配分を求める。

== 収益率

#definition[
  期首の価格 $P_0$ で買った資産が、期末に価格 $P_1$ になり、期間中に配当 $D$ を支払ったとする。この資産の期間の#strong[収益率]（rate of return）を
  $ R = (P_1 + D - P_0) / P_0 $
  と定める。
]

収益率は投資した金額に対する増加額の割合である。期首の時点で $P_1$ と $D$ は確定していない。したがって収益率 $R$ は確率変数であり、第 3 章の枠組みで扱われる。以下、資産は $n$ 個とし、資産 $i$ の収益率を $R_i$、その期待値を $mu_i = E[R_i]$、分散を $sigma_i^2 = V[R_i]$ と書く。資産 $i$ と $j$ の共分散は $sigma_(i j) = "Cov"[R_i, R_j]$ と書く。$i = j$ のとき $sigma_(i i) = sigma_i^2$ である。

== ポートフォリオとその重み

#definition[
  総投資額のうち、資産 $i$ に充てる割合を $w_i$ と書き、#strong[重み]（weight）と呼ぶ。重みは
  $ sum_(i=1)^n w_i = 1 $ <eq-budget>
  を満たす。重みの組 $bold(w) = (w_1, ..., w_n)$ のことを#term-meta((kana: "ぽーとふぉりお", ja: "ポートフォリオ", en: "portfolio"))#strong[ポートフォリオ]（portfolio）と呼ぶ。
]

重みの和が $1$ であることは、投資額の合計が手持ち資金に等しいことを表す。この和が $1$ であるという条件を、のちの章で使うために#term-meta((kana: "よさんせいやく", ja: "予算制約", en: "budget constraint"))#strong[予算制約]（budget constraint）と呼ぶ。$w_i > 1$ となることは、他の資産を空売りして得た資金を資産 $i$ に投じることを意味する。空売りとは資産を借りて売却し、後で買い戻して返す取引である。$0 < w_i < 1$ に限る場合を#term-meta((kana: "からうりせいやくのある", ja: "空売り制約のある", en: "short-sale constrained"))#strong[空売り制約のある]（short-sale constrained）場合と呼ぶ。本書では第 7 章で CAPM の仮定を定式化するまでは、空売りの可否を問わない一般の重みで議論する。

ポートフォリオの収益率は資産ごとの収益率の重み付き平均になる。

#lemma[
  重み $w_1, ..., w_n$ のポートフォリオの収益率は
  $ R_p = sum_(i=1)^n w_i R_i $ <eq-portfolio-return>
  である。
]<lem-portfolio-return>

#proof[
  期首の手持ち資金を $M$ とする。資産 $i$ に充てる金額は $w_i M$ であり、期末のその資産の価値は配当込みで $w_i M (1 + R_i)$ である。ポートフォリオ全体の期末価値は
  $ sum_(i=1)^n w_i M (1 + R_i) = M (1 + sum_(i=1)^n w_i R_i) $
  収益率の定義より、ポートフォリオの収益率は期末価値を $M$ で割って $1$ を引いたものであるから、$R_p = sum_(i=1)^n w_i R_i$ である。
]

== ポートフォリオの期待収益率と分散

=== 期待収益率

#theorem[
  ポートフォリオの期待収益率は
  $ E[R_p] = sum_(i=1)^n w_i mu_i $ <eq-portfolio-mean>
  である。
]<thm-portfolio-mean>

#proof[
  @lem-portfolio-return と @thm-linear により
  $ E[R_p] = E[sum_(i=1)^n w_i R_i] = sum_(i=1)^n w_i E[R_i] = sum_(i=1)^n w_i mu_i $
  である。
]

重みがすべて非負のとき、期待収益率は @lem-weighted-range により、各資産の期待収益率の最小値以上最大値以下に収まる。分散投資だけでは期待収益率を個別資産の範囲を超えて高めることはできない。ポートフォリオの本領は次に見る分散の側にある。

=== 二資産の分散

二つの資産だけからなるポートフォリオの分散を、まず完全に計算する。

#theorem[
  二資産の重みを $w_1 = w$、$w_2 = 1 - w$ とするとき、ポートフォリオの分散は
  $ V[R_p] = w^2 sigma_1^2 + (1 - w)^2 sigma_2^2 + 2 w (1 - w) sigma_(1 2) $ <eq-var-two>
  である。
]<thm-var-two>

#proof[
  @lem-portfolio-return より $R_p = w R_1 + (1 - w) R_2$ である。@thm-var-sum を $a = w$、$b = 1 - w$、$X = R_1$、$Y = R_2$ として適用すると
  $ V[R_p] = w^2 V[R_1] + (1 - w)^2 V[R_2] + 2 w (1 - w) "Cov"[R_1, R_2] $
  となる。共分散の記号を $sigma_(1 2)$ に置き換えると主張の等式を得る。
]

#corollary[
  相関係数を使って書くと
  $ V[R_p] = w^2 sigma_1^2 + (1 - w)^2 sigma_2^2 + 2 w (1 - w) rho_(1 2) sigma_1 sigma_2 $ <eq-var-rho>
  である。
]<cor-var-rho>

#proof[
  $sigma_(1 2) = rho_(1 2) sigma_1 sigma_2$ を @eq-var-two に代入するだけである。
]

分散の式に現れる第三の項、共分散の項が分散投資の本質である。二つの資産の相関係数が $1$ 未満であれば、この項の寄与が小さくなり、ポートフォリオの分散は抑えられる。次の定理はこの直観を確定的な形で述べる。

#theorem[
  （分散投資の利益）$sigma_1 > 0$、$sigma_2 > 0$、$rho_(1 2) < 1$ とする。このとき任意の $0 < w < 1$ に対して
  $ V[R_p] < w sigma_1^2 + (1 - w) sigma_2^2 $ <eq-diversification>
  が成り立つ。右辺は各資産に同じ重みで単独投資した場合の分散の加重平均である。
]

#proof[
  @eq-var-rho の右辺から加重平均を引き、差を計算する。$sigma_1^2$ と $sigma_2^2$ の係数を整理すると
  $ w^2 sigma_1^2 - w sigma_1^2 = -w (1 - w) sigma_1^2, quad (1 - w)^2 sigma_2^2 - (1 - w) sigma_2^2 = -w (1 - w) sigma_2^2 $
  である。共分散の項はそのまま残る。したがって差は
  $ V[R_p] - w sigma_1^2 - (1 - w) sigma_2^2 = -w (1 - w) (sigma_1^2 + sigma_2^2 - 2 rho_(1 2) sigma_1 sigma_2) $
  となる。括弧の中は
  $ sigma_1^2 + sigma_2^2 - 2 rho_(1 2) sigma_1 sigma_2 = (sigma_1 - sigma_2)^2 + 2 (1 - rho_(1 2)) sigma_1 sigma_2 $
  と変形できる。第一項は平方なので $0$ 以上であり、第二項は仮定 $rho_(1 2) < 1$ と $sigma_1, sigma_2 > 0$ より正である。よって括弧の中は正である。$0 < w < 1$ より $-w (1 - w) < 0$ なので、差は負であり、主張の不等式が成り立つ。
]

この定理の含意を整理する。相関係数が $1$ より小さい二つの資産に資金を分ければ、分散は同じ重みの加重平均、すなわち「リスクを資産に分けて持った」ときの期待される分散よりも必ず小さくなる。リスクは単純に足し合わされるのではなく、相関の低さに応じて一部が相殺される。これが分散投資がリスクを下げる理論的な根拠であり、マーコウィッツ @markowitz1952 の中心的な洞察である。

相関係数が $1$ のとき、二つの資産の収益率は比例して動く。このとき分散投資の利益は消失する。逆に、相関係数が負の場合、共分散の項は分散を強く削減する。

#example[
  二つの資産がともに $sigma_1 = sigma_2 = 20%$ の標準偏差を持ち、相関係数が $rho_(1 2) = 0.3$ であるとする。重みを $w = 1\/2$ にとると、@eq-var-rho より
  $ V[R_p] = 1/4 (0.04) + 1/4 (0.04) + 2 dot.c 1/4 dot.c 0.3 dot.c 0.2 dot.c 0.2 = 0.026 $
  標準偏差は $sqrt(0.026) tilde.op 16.1%$ である。単独投資の $20%$ と比べて、期待収益率が二資産の平均になるだけで、リスクは約 2 割減る。
]

=== $n$ 資産への一般化

任意の数の資産に対して、分散の式は二重和で書ける。

#theorem[
  重み $w_1, ..., w_n$ のポートフォリオの分散は
  $ V[R_p] = sum_(i=1)^n sum_(j=1)^n w_i w_j sigma_(i j) $ <eq-var-general>
  である。のちの節で使うため、右辺を $bold(w)^T bold(Sigma) bold(w)$ という二次形式の形にまとめて書く。ここで $bold(Sigma)$ は第 $(i, j)$ 成分が $sigma_(i j)$ である正方行列であり、成分を書き下せば
  $ bold(w)^T bold(Sigma) bold(w) = sum_(i=1)^n (bold(Sigma) bold(w))_i w_i = sum_(i=1)^n sum_(j=1)^n sigma_(i j) w_j w_i $
  であり、@eq-var-general の右辺と一致する。
]<thm-var-general>

#proof[
  $R_p = sum_(i=1)^n w_i R_i$ を分散の定義に代入して展開する。$mu_p = E[R_p]$ とおくと
  $ V[R_p] = E[(sum_(i=1)^n w_i R_i - mu_p)^2] = E[(sum_(i=1)^n w_i (R_i - mu_i))^2] $
  2 番目の等号では、$mu_p = sum w_i mu_i$ を使って期待値からのずれの形に書き直した。括弧の中の2乗は和の各項どうしの積の和である。
  $ (sum_(i=1)^n w_i (R_i - mu_i))^2 = sum_(i=1)^n sum_(j=1)^n w_i w_j (R_i - mu_i)(R_j - mu_j) $
  この展開は、和の積がすべての組み合わせの積の和になることによる。両辺の期待値を取り、@thm-linear で期待値を各項に分配すると
  $ V[R_p] = sum_(i=1)^n sum_(j=1)^n w_i w_j E[(R_i - mu_i)(R_j - mu_j)] = sum_(i=1)^n sum_(j=1)^n w_i w_j sigma_(i j) $
  となる。二次形式の表記については、行列とベクトルの積の定義より $(bold(Sigma) bold(w))_i = sum_(j=1)^n sigma_(i j) w_j$ なので、$bold(w)^T (bold(Sigma) bold(w)) = sum_(i=1)^n w_i sum_(j=1)^n sigma_(i j) w_j$ であり、和の順序と積の交換により @eq-var-general の右辺に一致する。
]

分散の共分散行列による表記を導入する。

#definition[
  第 $(i, j)$ 成分が $sigma_(i j)$ である $n$ 次正方行列を#term-meta((kana: "ぶんさんきょうぶんさんぎょうれつ", ja: "分散共分散行列", en: "covariance matrix"))#strong[分散共分散行列]（covariance matrix）と呼び、$bold(Sigma)$ と書く。
]

#corollary[
  分散共分散行列は対称である。すなわち $sigma_(i j) = sigma_(j i)$ がすべての $i, j$ で成り立つ。
]

#proof[
  $sigma_(i j) = "Cov"[R_i, R_j]$ であり、共分散は順序に依らないので $"Cov"[R_i, R_j] = "Cov"[R_j, R_i]$ である。
]

#lemma[
  $bold(Sigma)$ が逆行列を持つと仮定する。このとき $bold(Sigma)$ は正定値であり、任意の $bold(v) != bold(0)$ に対して $bold(v)^T bold(Sigma) bold(v) > 0$ である。
]<lemma-var-pos>

#proof[
  $X = sum_(i=1)^n v_i R_i$ と置く。@thm-var-general の主張とその証明の計算は、重みが予算制約 $sum_i w_i = 1$ を満たすかどうかに依らないので、重みを $v_i$ に置き換えて適用でき、
  $ bold(v)^T bold(Sigma) bold(v) = V[X] $
  が成り立つ。分散の定義より $V[X] >= 0$ であり、これで非負性は示された。

  厳密な正値を示す。$bold(v) != bold(0)$ とし、仮に $V[X] = 0$ であったとする。@lem-degenerate より、$X$ は確率 $1$ である定数 $c$ に等しい。このとき各資産 $i$ と $X$ の共分散は $0$ になる。実際、共分散の定義の期待値の中の $X - c$ が確率 $1$ で $0$ なので、
  $ "Cov"[R_i, X] = E[(R_i - mu_i)(X - c)] = 0 $
  である。他方でこの共分散は、共分散の定義を $X$ に代入して展開すると、@thm-linear により
  $ "Cov"[R_i, X] = E[(R_i - mu_i) sum_(j=1)^n v_j (R_j - mu_j)] = sum_(j=1)^n v_j sigma_(i j) = (bold(Sigma) bold(v))_i $
  となる。したがってすべての $i$ で $(bold(Sigma) bold(v))_i = 0$、すなわち $bold(Sigma) bold(v) = bold(0)$ である。ここで補題の仮定、$bold(Sigma)$ が逆行列を持つことと @cor-solve の一意性より、$bold(v) = bold(Sigma)^(-1) bold(0) = bold(0)$ となり、$bold(v) != bold(0)$ に矛盾する。よって $V[X] > 0$、すなわち $bold(v)^T bold(Sigma) bold(v) > 0$ である。
]

この補題と @rem-pd-regular により、分散共分散行列について、正則であることと正定値であることは同値である。正則性が崩れるのは、ある非自明な重みの組み合わせでポートフォリオの分散が厳密に $0$ になるとき、すなわち相関が完全に揃った資産が混在するときである。現実の資産間の相関は完全ではないため、この条件は穏当である。

== 最小分散ポートフォリオ

=== 二資産の場合

期待収益率を考慮せず、分散だけを最小化する重みを求める。二資産の場合、分散は $w$ の2次関数なので、@eq-quad-min が直接適用できる。

#theorem[
  $sigma_1^2 + sigma_2^2 - 2 sigma_(1 2) > 0$ とする。二資産ポートフォリオの分散 @eq-var-two を最小にする重みは
  $ w^* = (sigma_2^2 - sigma_(1 2)) / (sigma_1^2 + sigma_2^2 - 2 sigma_(1 2)) $ <eq-minvar2>
  であり、資産 2 の重みは $1 - w^*$ である。
]<thm-minvar2>

#proof[
  @eq-var-two の右辺を $w$ について整理する。
  $ V[R_p] &= w^2 sigma_1^2 + (1 - 2w + w^2) sigma_2^2 + 2 (w - w^2) sigma_(1 2) \
    &= (sigma_1^2 + sigma_2^2 - 2 sigma_(1 2)) w^2 + (- 2 sigma_2^2 + 2 sigma_(1 2)) w + sigma_2^2 $
  これは $a w^2 + b w + c$ の形で、$a = sigma_1^2 + sigma_2^2 - 2 sigma_(1 2)$、$b = 2(sigma_(1 2) - sigma_2^2)$、$c = sigma_2^2$ である。$a$ は定理の仮定より正である。@eq-quad-min より、最小値は
  $ w^* = -b / (2 a) = (sigma_2^2 - sigma_(1 2)) / (sigma_1^2 + sigma_2^2 - 2 sigma_(1 2)) $
  で達成される。
]

仮定 $sigma_1^2 + sigma_2^2 - 2 sigma_(1 2) > 0$ は、二つの資産の収益率が確率的に一致しないことを表す。実際、この量は $V[R_1 - R_2]$ に等しい。$V[R_1 - R_2] = sigma_1^2 + sigma_2^2 - 2 sigma_(1 2)$ は @thm-var-sum で $a = 1$、$b = -1$ として確かめられる。

=== $n$ 資産の場合

$n$ 資産の場合、重みは $n$ 個の変数で、予算制約 $sum w_i = 1$ の下で分散 $bold(w)^T bold(Sigma) bold(w)$ を最小化する。変数を一つずつ消去する代入法でも解けるが、一般の $n$ に対処できる方法として、第 2 章で導入したラグランジュの未定乗数法を適用する。

#theorem[
  $bold(Sigma)$ を正定値な分散共分散行列とする。予算制約の下でポートフォリオの分散を最小にする重みは
  $ bold(w)^"*" = (bold(Sigma)^(-1) bold(1)) / (bold(1)^T bold(Sigma)^(-1) bold(1)) $ <eq-minvar-n>
  である。ただし分母は正である。
]<thm-minvar-n>

#proof[
  最小化する目的関数は $f(bold(w)) = bold(w)^T bold(Sigma) bold(w)$、制約は $g(bold(w)) = bold(w)^T bold(1) - 1 = 0$ である。ラグランジュ関数は
  $ L = bold(w)^T bold(Sigma) bold(w) - lambda (bold(w)^T bold(1) - 1) $
  である。まず $f$ の $w_k$ についての偏微分係数を求める。成分で書くと
  $ f(bold(w)) = sum_(i=1)^n sum_(j=1)^n w_i w_j sigma_(i j) $
  であり、$w_k$ を含む項は $i = k$ または $j = k$ の項だけである。$w_k$ で微分すると、$i = k$ の項から $sum_(j=1)^n w_j sigma_(k j)$、$j = k$ の項から $sum_(i=1)^n w_i sigma_(i k)$ が得られる。対称性 $sigma_(k j) = sigma_(j k)$ より両者は等しいので
  $ (partial f)/(partial w_k) = 2 sum_(j=1)^n sigma_(k j) w_j $
  である。右辺は $2 bold(Sigma) bold(w)$ の第 $k$ 成分である。制約の項は $partial\/(partial w_k)(bold(w)^T bold(1)) = 1$ なので、ラグランジュ関数の停留条件 $partial L \/ partial w_k = 0$ はすべての $k$ に対して
  $ 2 bold(Sigma) bold(w) = lambda bold(1) $ <eq-foc>
  であることを意味する。$bold(Sigma)$ の正定値性から逆行列が存在するので
  $ bold(w) = (lambda\/2) bold(Sigma)^(-1) bold(1) $
  と解ける。$lambda$ を決めるため、両辺に左から $bold(1)^T$ を掛けると、予算制約 $bold(1)^T bold(w) = 1$ より
  $ 1 = (lambda\/2) bold(1)^T bold(Sigma)^(-1) bold(1) quad : quad lambda = 2 / (bold(1)^T bold(Sigma)^(-1) bold(1)) $
  が得られる。これを代入すると主張の式が出る。残るは $bold(1)^T bold(Sigma)^(-1) bold(1) > 0$ である。$bold(Sigma)^(-1)$ は正定値である。実際、$bold(x) != bold(0)$ のとき、$bold(Sigma)^(-1)$ の対称性を使うと
  $ bold(x)^T bold(Sigma)^(-1) bold(x) = (bold(Sigma)^(-1) bold(x))^T bold(Sigma) (bold(Sigma)^(-1) bold(x)) $
  と変形でき、$bold(Sigma)^(-1) bold(x) != bold(0)$ と $bold(Sigma)$ の正定値性より右辺は正である。$bold(x) = bold(1)$ とすれば $bold(1)^T bold(Sigma)^(-1) bold(1) > 0$ である。

  最後に、この停留点が最小点であることを確認する。任意の重み $bold(w)$ に対して
  $ (bold(w) - bold(w)^"*")^T bold(Sigma) (bold(w) - bold(w)^"*") >= 0 $
  が正定値性より成り立つ。これを展開すると
  $ bold(w)^T bold(Sigma) bold(w) >= (bold(w)^"*")^T bold(Sigma) bold(w)^"*" + 2 (bold(w) - bold(w)^"*")^T bold(Sigma) bold(w)^"*" $
  である。右辺の第二項に @eq-foc の $bold(w)^"*"$ を満たす式 $2 bold(Sigma) bold(w)^"*" = lambda^* bold(1)$ を使うと
  $ 2 (bold(w) - bold(w)^"*")^T bold(Sigma) bold(w)^"*" = lambda^* (bold(w)^T bold(1) - (bold(w)^"*")^T bold(1)) = lambda^* (1 - 1) = 0 $
  となる。どちらの重みも予算制約を満たすからである。したがって任意の実行可能な $bold(w)$ に対して
  $ bold(w)^T bold(Sigma) bold(w) >= (bold(w)^"*")^T bold(Sigma) bold(w)^"*" $
  であり、$bold(w)^"*"$ が分散を最小にする。
]

分散最小化は期待収益率を一切使わない基準である。リスクだけを気にする投資家には十分だが、期待収益率を上げるために多少のリスクは負いたい投資家には合わない。次章では、期待収益率とリスクの両方を評価する枠組みとして、安全資産とリスク資産の組み合わせを分析し、シャープレシオという効率の指標に到達する。
