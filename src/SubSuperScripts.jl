function subsuperchar(c, sub)
    subscripts = Dict(
        '0' => '₀',
        '1' => '₁',
        '2' => '₂',
        '3' => '₃',
        '4' => '₄',
        '5' => '₅',
        '6' => '₆',
        '7' => '₇',
        '8' => '₈',
        '9' => '₉',
    )

    superscripts = Dict(
        '0' => '⁰',
        '1' => '¹',
        '2' => '²',
        '3' => '³',
        '4' => '⁴',
        '5' => '⁵',
        '6' => '⁶',
        '7' => '⁷',
        '8' => '⁸',
        '9' => '⁹',
    )
    if sub
        return subscripts[c]
    else
        return superscripts[c]
    end
end

function subsuperstring(x, sub=false)
    s = string(x)
    carr = [subsuperchar(c, sub) for c in s]
    return join(carr, "")
end
