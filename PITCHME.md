---
theme: "white"
transition: "zoom"
highlightTheme: "darkula" 
---

# _IoC container_ in Arena plugins

---

### Enabling _IoC_ in client project
`Using DIPS.Infrastructure.Container;`

---

### In combination with _MEF_
```C#
public class CompositionRoot : ICompositionRoot
{
  public void Compose(IContainer container)
  {
    container.Register<IBar>(c => 
      new Bar(c.Get<IFooBar>(), ContainerScope.Transient);
  }
}
```

```C#
// MEF picks up this one
[Export]
public class Foo
{
  [ImportingConstructor]
  public Foo(IBar bar) { ... }
}
```

```C#
public class Bar : IBar
{
  public Bar(IFooBar fooBar) { ... }
}
```

---

### In combination with `xUnit`
Shameless plagiarism of
https://github.com/seesharper/LightInject.xUnit

---

### Lessons learned

---

#### Lessons learned
DO Use factory methods to 
- speed things up 
- avoid property injection

---

#### Lessons learned
Factory methods
```c#
public void Compose(IContainer container)
{
    container.Register(CreateFoo, ContainerScope.Transient);
}

private IFoo CreateFoo(IContainer container)
{
    return new Foo(container.Get<IBar>());
}
```
instead of 
```c#
public void Compose(IContainer container)
{
    container.Register<IFoo, Foo>(ContainerScope.Transient);
}
```

---

#### Lessons learned
DON'T depend on other's implementations

... at least until `Infrastructure 7.0` is released

---

#### Lessons learned
... to be continued at Musk HQ /
[TileDesigner](http://vd-tfs03:8080/tfs/DefaultCollection/DIPS/Musk/_git/TileDesigner)