import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { GetInfoService } from '../services/get-info.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-certifier-sign-in',
  templateUrl: './certifier-sign-in.component.html',
  styleUrls: ['./certifier-sign-in.component.css']
})
export class CertifierSignInComponent implements OnInit {

  public certifierSigninForm: FormGroup;

  constructor(private formBuilder: FormBuilder,private getInfoService: GetInfoService,private route : Router) { }

  ngOnInit(): void {
    this.certifierSigninForm = this.formBuilder.group({
      name: ['',Validators.required],
      uid: ['', [Validators.required]],
      password: ['',[Validators.required]],
      type:['',[Validators.required]] 
    });
  }

  onSubmit(){
    if(this.certifierSigninForm.valid){
      this.getInfoService.certifierSignin(this.certifierSigninForm.value).subscribe((data) => { });
      this.route.navigate(["/login/certifier"]);
    }
  }

}
