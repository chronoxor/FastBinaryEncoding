using System;
using System.Diagnostics;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace Create
{
    public static class Program
    {
        public static void Main()
        {
            // Create a new account using FBE model
            var account = new AccountModel();
            long modelBegin = account.CreateBegin();
            long accountBegin = account.model.SetBegin();
            account.model.id.Set(1);
            account.model.name.Set("Test");
            account.model.state.Set(State.good);
            long walletBegin = account.model.wallet.SetBegin();
            account.model.wallet.currency.Set("USD");
            account.model.wallet.amount.Set(1000.0);
            account.model.wallet.SetEnd(walletBegin);
            account.model.SetEnd(accountBegin);
            account.CreateEnd(modelBegin);
            Debug.Assert(account.Verify());

            // Show the serialized FBE size
            Console.WriteLine($"FBE size: {account.Buffer.Size}");

            // Access the account using the FBE model
            var access = new AccountModel();
            access.Attach(account.Buffer);
            Debug.Assert(access.Verify());

            accountBegin = access.model.GetBegin();
            access.model.id.Get(out var id);
            access.model.name.Get(out var name);
            access.model.state.Get(out var state);
            walletBegin = access.model.wallet.GetBegin();
            access.model.wallet.currency.Get(out var walletCurrency);
            access.model.wallet.amount.Get(out var walletAmount);
            access.model.wallet.GetEnd(walletBegin);
            access.model.GetEnd(accountBegin);

            // Show account content
            Console.WriteLine();
            Console.WriteLine($"account.id = {id}");
            Console.WriteLine($"account.name = {name}");
            Console.WriteLine($"account.state = {state}");
            Console.WriteLine($"account.wallet.currency = {walletCurrency}");
            Console.WriteLine($"account.wallet.amount = {walletAmount}");
        }
    }
}
