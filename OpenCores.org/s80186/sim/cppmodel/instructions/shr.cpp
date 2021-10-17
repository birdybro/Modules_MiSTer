// Copyright Jamie Iles, 2017
//
// This file is part of s80x86.
//
// s80x86 is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// s80x86 is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with s80x86.  If not, see <http://www.gnu.org/licenses/>.

template <typename T>
std::pair<uint16_t, T> do_shr(T v, int count)
{
    uint16_t flags = 0;
    T sign_bit = 0x80 << (8 * (sizeof(T) - 1));
    if (v & sign_bit)
        flags |= OF;

    for (int i = 0; i < count; ++i) {
        flags &= ~CF;
        if (v & 0x1)
            flags |= CF;
        v >>= 1;
    }

    if (!v)
        flags |= ZF;
    if (!__builtin_parity(v & 0xff))
        flags |= PF;

    return std::make_pair(flags, v);
}

// shr r/m, N
void EmulatorPimpl::shrc0()
{
    auto v = read_data<uint8_t>();
    auto count = fetch_byte();
    uint16_t flags;

    if (!(count & 0x1f))
        return;

    std::tie(flags, v) = do_shr(v, count & 0x1f);

    write_data<uint8_t>(v);
    registers->set_flags(flags, CF | ZF | PF | SF);
}

// shr r/m, 1
void EmulatorPimpl::shrc1()
{
    auto v = read_data<uint16_t>();
    auto count = fetch_byte();
    uint16_t flags;

    if (!(count & 0x1f))
        return;

    std::tie(flags, v) = do_shr(v, count & 0x1f);

    write_data<uint16_t>(v);
    registers->set_flags(flags, CF | ZF | PF | SF);
}

// shr r/m, 1
void EmulatorPimpl::shrd0()
{
    auto v = read_data<uint8_t>();
    uint16_t flags;

    std::tie(flags, v) = do_shr(v, 1);

    write_data<uint8_t>(v);
    registers->set_flags(flags, OF | CF | ZF | PF | SF);
}

// shr r/m, 1
void EmulatorPimpl::shrd1()
{
    auto v = read_data<uint16_t>();
    uint16_t flags;

    std::tie(flags, v) = do_shr(v, 1);

    write_data<uint16_t>(v);
    registers->set_flags(flags, OF | CF | ZF | PF | SF);
}

// shr r/m, N
void EmulatorPimpl::shrd2()
{
    auto v = read_data<uint8_t>();
    uint16_t flags;

    if (!registers->get(CL))
        return;

    std::tie(flags, v) = do_shr(v, registers->get(CL));

    write_data<uint8_t>(v);
    registers->set_flags(flags, CF | ZF | PF | SF);
}

// shr r/m, N
void EmulatorPimpl::shrd3()
{
    auto v = read_data<uint16_t>();
    uint16_t flags;

    if (!registers->get(CL))
        return;

    std::tie(flags, v) = do_shr(v, registers->get(CL));

    write_data<uint16_t>(v);
    registers->set_flags(flags, CF | ZF | PF | SF);
}
