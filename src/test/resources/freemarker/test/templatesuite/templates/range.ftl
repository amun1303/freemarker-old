<#----------------------->
<#-- Range expressions -->

<@assertEquals actual=(1..2)?join(' ') expected="1 2" />
<@assertEquals actual=(1..1)?join(' ') expected="1" />
<@assertEquals actual=(1..0)?join(' ') expected="1 0" />
<@assertEquals actual=(1..-1)?join(' ') expected="1 0 -1" />

<@assertEquals actual=(1..<3)?join(' ') expected="1 2" />
<@assertEquals actual=(1..<2)?join(' ') expected="1" />
<@assertEquals actual=(1..<1)?join(' ') expected="" />
<@assertEquals actual=(1..<0)?join(' ') expected="1" />
<@assertEquals actual=(1..<-1)?join(' ') expected="1 0" />
<@assertEquals actual=(1..<-2)?join(' ') expected="1 0 -1" />

<@assertEquals actual=(1..!3)?join(' ') expected="1 2" />
<@assertEquals actual=(1..!2)?join(' ') expected="1" />
<@assertEquals actual=(1..!1)?join(' ') expected="" />
<@assertEquals actual=(1..!0)?join(' ') expected="1" />
<@assertEquals actual=(1..!-1)?join(' ') expected="1 0" />
<@assertEquals actual=(1..!-2)?join(' ') expected="1 0 -1" />

<@assertEquals actual='abc'[0..1] expected="ab" />


<#--------------------->
<#-- String slicing: -->

<#assign s = 'abcd'>

<@assertEquals actual=s[0..] expected="abcd" />
<@assertEquals actual=s[1..] expected="bcd" />
<@assertEquals actual=s[2..] expected="cd" />
<@assertEquals actual=s[3..] expected="d" />
<@assertEquals actual=s[4..] expected="" />

<@assertEquals actual=s[1..2] expected="bc" />
<@assertEquals actual=s[1..1] expected="b" />
<@assertEquals actual=s[0..1] expected="ab" />
<@assertEquals actual=s[0..0] expected="a" />

<@assertEquals actual=s[1..<3] expected="bc" />
<@assertEquals actual=s[1..!3] expected="bc" />
<@assertEquals actual=s[1..<2] expected="b" />
<@assertEquals actual=s[1..<0] expected="b" />
<@assertEquals actual=s[1..<1] expected="" />
<@assertEquals actual=s[0..<0] expected="" />

<#-- Legacy string backward-range bug kept for compatibility: -->
<@assertEquals actual=s[1..0] expected="" />
<@assertEquals actual=s[2..1] expected="" />
<@assertFails messageRegexp="StringIndexOutOfBounds|negative">
  <@assertEquals actual=s[0..-1] expected="" />
</@assertFails>
<@assertFails messageRegexp="StringIndexOutOfBounds|decreasing">
  <@assertEquals actual=s[3..1] expected="" />
</@assertFails>

<@assertFails message="5 is out of bounds">
  <#assign _ = s[5..] />
</@assertFails>
<@assertFails message="5 is out of bounds">
  <#assign _ = s[1..5] />
</@assertFails>
<@assertFails message="negative">
  <#assign _ = s[-1..1] />
</@assertFails>

<#assign r = 1..2>
<@assertEquals actual=s[r] expected="bc" />

<#----------------------->
<#-- Sequence slicing: -->

<#assign s = ['a', 'b', 'c', 'd']>

<@assertEquals actual=s[0..]?join('') expected="abcd" />
<@assertEquals actual=s[1..]?join('') expected="bcd" />
<@assertEquals actual=s[2..]?join('') expected="cd" />
<@assertEquals actual=s[3..]?join('') expected="d" />
<@assertEquals actual=s[4..]?join('') expected="" />

<@assertEquals actual=s[1..2]?join('') expected="bc" />
<@assertEquals actual=s[1..1]?join('') expected="b" />
<@assertEquals actual=s[0..1]?join('') expected="ab" />
<@assertEquals actual=s[0..0]?join('') expected="a" />

<@assertEquals actual=s[1..<3]?join('') expected="bc" />
<@assertEquals actual=s[1..!3]?join('') expected="bc" />
<@assertEquals actual=s[1..<2]?join('') expected="b" />
<@assertEquals actual=s[1..<0]?join('') expected="b" />
<@assertEquals actual=s[1..<1]?join('') expected="" />
<@assertEquals actual=s[0..<0]?join('') expected="" />

<@assertEquals actual=s[1..0]?join('') expected="ba" />
<@assertEquals actual=s[2..1]?join('') expected="cb" />
<@assertEquals actual=s[2..0]?join('') expected="cba" />

<@assertFails message="5 is out of bounds">
  <#assign _ = s[5..] />
</@assertFails>
<@assertFails message="5 is out of bounds">
  <#assign _ = s[1..5] />
</@assertFails>
<@assertFails message="negative">
  <#assign _ = s[-1..1] />
</@assertFails>
