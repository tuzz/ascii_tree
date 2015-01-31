require "spec_helper"

describe AsciiTree do

  it "works for the 'Usage' example in the readme" do
    root = AsciiTree.parse('

          # Christmas themed tree:

                  chestnuts
                  /     |  \
              roasting  on  an
               /   \         \
            open  fire       jack
                  /   \
                frost  nipping
                        /  |  \
                      on  your nose   # Ouch!

    ')

    expect(root.id).to eq("chestnuts")
    expect(root.parent).to be_nil
    expect(root.children.size).to eq(3)

    roasting, on, an = root.children
    expect(roasting.id).to eq("roasting")
    expect(on.id).to eq("on")
    expect(an.id).to eq("an")
    expect(roasting.parent).to eq(root)
    expect(on.parent).to eq(root)
    expect(an.parent).to eq(root)
    expect(roasting.children.size).to eq(2)
    expect(on.children.size).to eq(0)
    expect(an.children.size).to eq(1)

    open, fire = roasting.children
    jack = an.children.first
    expect(open.id).to eq("open")
    expect(fire.id).to eq("fire")
    expect(jack.id).to eq("jack")
    expect(open.parent).to eq(roasting)
    expect(fire.parent).to eq(roasting)
    expect(jack.parent).to eq(an)
    expect(open.children.size).to eq(0)
    expect(fire.children.size).to eq(2)
    expect(jack.children.size).to eq(0)

    frost, nipping = fire.children
    expect(frost.id).to eq("frost")
    expect(nipping.id).to eq("nipping")
    expect(frost.parent).to eq(fire)
    expect(nipping.parent).to eq(fire)
    expect(frost.children.size).to eq(0)
    expect(nipping.children.size).to eq(3)

    on, your, nose = nipping.children
    expect(on.id).to eq("on")
    expect(your.id).to eq("your")
    expect(nose.id).to eq("nose")
    expect(on.parent).to eq(nipping)
    expect(your.parent).to eq(nipping)
    expect(nose.parent).to eq(nipping)
    expect(on.children.size).to eq(0)
    expect(your.children.size).to eq(0)
    expect(nose.children.size).to eq(0)
  end

  it "works for the 'Multiple Words' example in the readme" do
    root = AsciiTree.parse('

              (this is a single node)
                  /    |    |    |   \
        (so is this)  but these are separate

    ')

    expect(root.id).to eq("this is a single node")
    expect(root.children.size).to eq(5)

    so_is_this, but, these, are, separate = root.children
    expect(so_is_this.id).to eq("so is this")
    expect(but.id).to eq("but")
    expect(these.id).to eq("these")
    expect(are.id).to eq("are")
    expect(separate.id).to eq("separate")
  end

  it "works for the 'Values' example in the readme" do
  root = AsciiTree.parse('

          root{123}
          /    \
      a{"foo"}  b
        / \
       c   d{ [1, 2, 3].reverse }

  ')

    expect(root.value).to eq(123)
    expect(root.children.size).to eq(2)

    a, b = root.children
    expect(a.value).to eq("foo")
    expect(b.value).to be_nil
    expect(a.children.size).to eq(2)

    c, d = a.children
    expect(c.value).to be_nil
    expect(d.value).to eq [3, 2, 1]
  end

end
