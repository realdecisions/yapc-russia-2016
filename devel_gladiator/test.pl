#!perl
use strict;
use Devel::Gladiator;
use Devel::Cycle -raw;
use B;

*B::SV::blessed = sub {
    return $_[0]->FLAGS & 0x00100000;    #SVs_OBJECT;
};

# Пример использования Devel::Gladiator + Devel::Cycle
# Создаем несколько утекающих объектов
foreach ( 1 .. 5 ) {
    my $req = FakeLeakedRequest->new();
    $req->function_with_leak;
}

# $req  - более не доступна нам, но объекты живы.

# Получаем снапшот арены
my $arena = Devel::Gladiator::walk_arena();
foreach my $sv (@$arena) {

    # Поиск конкретных утекших объектов по имени пакеты
    if (0) {
        if ( ref($sv) eq 'FakeLeakedRequest' ) {
            Devel::Cycle::find_cycle($sv);
        }
    }

    #Поиск любых утекших объектов
    if (1) {
        my $bsv = B::svref_2object($sv);
        #Учитываем только "блесснутые" хэши и массивы
        if ( $bsv->blessed && ( ref $bsv eq 'B::AV' || ref $bsv eq 'B::HV' ) ) {
            Devel::Cycle::find_cycle($sv);
        }
    }

}

package FakeLeakedRequest;

sub new {
    bless {}, shift;
}

sub function_with_leak {
    my $self = shift;
    $self->{oops} = sub {
        $self;
    };
}